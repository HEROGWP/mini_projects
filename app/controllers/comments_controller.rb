class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_topic
	before_action :set_comment, :only => [:update, :destroy]
	before_action :set_comments, :except => [:create]
	

	def create
		@comment = @topic.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			@comment.create_pictures(params[:photos])
			@status = "success"
		else
			@url = topic_comments_path(@topic)
			@action = "post"
			@submit_name = "Create"
			@status = "faild"
		end
		set_comments
		set_pagination
		respond_to do |format|
			format.js
		end

	end

	def update
		@comment = @topic.comments.find(params[:id])
		if @comment.update(comment_params) && (current_user == @comment.user || current_user.admin?)
			
			@comment.destroy_pictures(params[:photos])
			@comment.create_pictures(params[:photos])

			flash[:notice] = "success to update"
			
		else
			@url = topic_comment_path(@topic, @comment)
			@action = "patch"
			@submit_name = "Update"
			flash[:alert] = "failed to update"

		end
		set_pagination
		redirect_to topic_path(params[:topic_id], :status => @comment.status)
	end

	def destroy
		if current_user == @comment.user || current_user.admin?
			set_page(@comment)
			@comment.destroy
			flash[:notice] = "success to delete"
		else
			flash[:alert] = "failed to delete"
		end
		
		set_pagination
		if @jump
			redirect_to topic_path(params[:topic_id],:page => @page, :status => @comment.status)
		else
			respond_to do |format|
				format.js
			end
		end
			
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :status, :publish_time)
	end

	def set_comments
		Comment.all.change_status
		@comments = @topic.comments.includes(:user => [:profile]).order("updated_at DESC")

		if current_user.admin? && @comment.status == "draft"
			@comments = @comments.where(:status => "draft")
		elsif @comment.status == "draft"
			@comments = @comments.where(:status => "draft", :user_id => current_user.id)
		else
			@comments = @comments.where(:status => "published")
		end
		@topic_id = params[:topic_id]
	end
	
	def set_pagination
	 @comments = @comments.page(params[:page]).per(5)
	end

	def set_comment
		@comment = Comment.find(params[:id])
	end

	def set_topic
		@topic = Topic.find(params[:topic_id])
	end

	def set_page(comment)
		count = @comments.find_index(comment) + 1
		if @comments.last == comment && ( count % 5 == 1)
			@jump = "jump"
			@page = count / 5
		elsif (count % 5 ) == 0
			@page = count / 5 
		else
			@page = count / 5 + 1
		end
	end
end
