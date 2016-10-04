class CommentsController < ApplicationController
	before_action :authenticate_user!
	before_action :comments, :only => [:create, :update]
	before_action :comment, :only => [:update, :destroy]
	before_action :topic

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

			redirect_to topic_path(params[:topic_id])

	end

	def update
		@comment = @topic.comments.find(params[:id])
		if @comment.update(comment_params)
			flash[:notice] = "success to update"
			
		else
			@url = topic_comment_path(@topic, @comment)
			@action = "patch"
			@submit_name = "Update"
			flash[:alert] = "failed to update"

		end

		redirect_to topic_path(params[:topic_id])
	end

	def destroy
		@comment.destroy
		flash[:notice] = "success to delete"
		@count = comments_count
		@page = params[:page].to_i
		if @count % 5 == 0
			@page = @page - 1
		end 
		redirect_to topic_path(params[:topic_id],:page => @page)
	end

	private

	def comment_params
		params.require(:comment).permit(:content)
	end

	def comments
		@comments = Topic.find(params[:topic_id]).comments.page(params[:page]).per(5)
	end

	def comment
		@comment = Comment.find(params[:id])
	end

	def topic
		@topic = Topic.find(params[:topic_id])
	end

	def comments_count
		Topic.find(params[:topic_id]).comments.all.count
	end
end
