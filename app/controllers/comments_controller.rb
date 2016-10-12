class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_comments
	before_action :set_comment, :only => [:update, :destroy]
	before_action :set_topic

	def create
		@comment = @topic.comments.build(comment_params)
		@comment.user = current_user
		if @comment.save
			flash[:notice] = "success to create"
		else
			@url = topic_comments_path(@topic)
			@action = "post"
			@submit_name = "Create"
			flash[:alert] = "failed to create"

		end
		set_pagination
		redirect_to topic_path(params[:topic_id], :status => @comment.status)

	end

	def update
		@comment = @topic.comments.find(params[:id])
		if @comment.update(comment_params) && (current_user == @comment.user || current_user.admin?)
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
		redirect_to topic_path(params[:topic_id],:page => @page, :status => @comment.status)
	end

	private

	def comment_params
		params.require(:comment).permit(:content, :status)
	end

	def set_comments
		@comments = Topic.find(params[:topic_id]).comments.order("updated_at DESC")

		if current_user.admin? && params[:status] == "draft"
			@comments = @comments.where(:status => params[:status])
		elsif params[:status] == "draft"
			@comments = @comments.where(:status => "draft", :user_id => current_user.id)
		else
			@comments = @comments.where(:status => "published")
		end
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
		count = @comments.find_index(comment)
		if @comments.last == comment && ( count % 5 ==1)
			@page = count / 5
		elsif (count % 5 ) == 0
			@page = count / 5 
		else
			@page = count / 5 + 1
		end
	end
end
