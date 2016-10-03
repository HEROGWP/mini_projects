class TopicsController < ApplicationController
	before_action :authenticate_user!
	before_action :topics, :only => [:index, :create, :update]
	before_action :topic, :only => [:show, :update, :destroy]
	before_action :categories, :only => [:index, :create, :update]
	
	def index
		if params[:id]
			@topic = Topic.find(params[:id])
			@submit_name = "Update"
		else
			@topic = current_user.topics.build
			@submit_name = "Create"
		end

	end
	def show
		if params[:id] && params[:comment_id]
			@comment = Comment.find(params[:comment_id])
			@url = topic_comment_path(@topic, @comment)
			@action = "patch"
			@submit_name = "Update"
		else
			@comment = @topic.comments.build
			@url = topic_comments_path(@topic)
			@action = "post"
			@submit_name = "Create"
		end

		
		@comments = @topic.comments.order("updated_at DESC").page(params[:page]).per(5)

	end
	def create
		@topic = current_user.topics.build(topic_params)
		if @topic.save
			flash[:notice] = "success to create"
			@count = topics_count
			(@count % 5 == 0) ? (@page = @count / 5) : (@page = @count / 5 + 1)
			redirect_to topics_path(:page => @page)
		else
			flash[:alert] = "failed to create"
			render :action => :index
		end
	end

	def update
		@topic = current_user.topics.find(params[:id])
		if @topic.update(topic_params)
			flash[:notice] = "success to update"
			redirect_to topics_path(:page => params[:page])
		else
			flash[:alert] = "failed to update"
			render :action => :index
		end
	end

	def destroy
		@topic.destroy
		flash[:notice] = "success to delete"
		@count = topics_count
		@page = params[:page].to_i
		if @count % 5 == 0
			@page = @page - 1
		end 
		redirect_to topics_path(:page => @page)
	end

	private

	def topic_params
		params.require(:topic).permit(:title, :content, :category_ids => [])
	end

	def topics
		if params[:order] == "comments"
      order_by = "comments_count DESC"
    elsif params[:order] == "updated_at"
    	order_by = "updated_at DESC"
    else   
      order_by = "created_at"
    end
    
    if params[:category]
    	@category = Category.find_by(:name => params[:category])
			@topics = @category.topics.order("#{order_by}").page(params[:page]).per(5)
    else
    	@topics = Topic.order("#{order_by}").page(params[:page]).per(5)
		end
	end

	def topic
		@topic = Topic.find(params[:id])
	end

	def topics_count
		Topic.all.count
	end

	def categories
		@categories = Category.all
	end
end
