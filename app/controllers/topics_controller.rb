class TopicsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_topics, :only => [:index, :create, :update, :destroy]
	before_action :set_topic, :only => [:show, :update, :destroy]
	before_action :categories, :only => [:index, :create, :update]

	def index
		if params[:id]
			@topic = Topic.find(params[:id])
			@submit_name = "Update"
		else
			@topic = current_user.topics.build
			@submit_name = "Create"
		end
		set_pagination
	end
	def show
		@favorite = current_user.favorites.find_by(:topic_id => params[:id])
		@topic.views += 1
		@topic.save
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

		
		@comments = @topic.comments.includes(:user => [:profile]).order("updated_at DESC").page(params[:page]).per(5)

		if current_user.admin? && params[:status] == "draft"
			@comments = @comments.where(:status => "draft")
		elsif params[:status] == "draft"
			@comments = @comments.where(:status => "draft", :user_id => current_user.id)
		else
			@comments = @comments.where(:status => "published")
		end

	end
	def create
		@topic = current_user.topics.build(topic_params)
		if @topic.save
			flash[:notice] = "success to create"
			set_topics_when_create(@topic)
			@count = @topics.size
			(@count % 5 == 0) ? (@page = @count / 5) : (@page = @count / 5 + 1)
			set_pagination
			redirect_to topics_path(:page => @page, :status => @topic.status)
		else
			flash[:alert] = "failed to create"
			set_pagination
			render :action => :index
		end
	end

	def update
		@topic = Topic.find(params[:id])
		if @topic.update(topic_params) && (current_user == @topic.user || current_user.admin?)
			flash[:notice] = "success to update"
			redirect_to topics_path(:page => @page, :status => @topic.status)
		else
			flash[:alert] = "failed to update"
			render :action => :index
		end
		set_pagination
	end

	def destroy
		if current_user == @topic.user || current_user.admin?
			set_page(@topic)
			@topic.destroy
			flash[:notice] = "success to delete"
			
			redirect_to topics_path(:page => @page, :status => params[:status], :order => params[:order], :category => params[:category])
		else
			flash[:alert] = "failed to delete"
			redirect_to :back
		end
		set_pagination
	end

	private

	def topic_params
		params.require(:topic).permit(:title, :content, :status, :category_ids => [])
	end

	def set_topics
		if params[:order] == "comments"
      order_by = "comments_count DESC"
    elsif params[:order] == "updated_at"
    	order_by = "updated_at DESC"
    elsif params[:order] == "views"
    	order_by = "views DESC"
    else   
      order_by = "created_at"
    end
    @category = Category.find_by(:name => params[:category])
    
    if params[:category] && params[:order] == "latest_comment"
			@topics = @category.topics.joins(:comments).order("comments.updated_at DESC").group("id")
    elsif params[:category]
			@topics = @category.topics.order("#{order_by}")
	  else
    	if params[:order] == "latest_comment"
				@topics = Topic.joins(:comments).order("comments.updated_at DESC").group("id")
			else
    		@topics = Topic.order("#{order_by}")
			end
		end


		if current_user.admin? && params[:status] == "draft"
			@topics = @topics.where(:status => params[:status])
		elsif params[:status] == "draft"
			@topics = @topics.where(:status => "draft", :user_id => current_user.id)
		else
			@topics = @topics.where(:status => "published")
		end
	end

	def set_pagination		
		@topics = @topics.includes(:user => [:profile]).page(params[:page]).per(5)
	end

	def set_topic
		@topic = Topic.find(params[:id])
	end

	def set_topics_when_create(topic)
		if current_user.admin? && topic.status == "draft"
			@topics = Topic.where(:status => "draft")
		elsif topic.status == "draft"
			@topics = Topic.where(:status => "draft", :user_id => current_user.id)
		else
			@topics = Topic.where(:status => "published")
		end
	end

	def set_page(topic)
		count = @topics.find_index(topic)
		if @topics.last == topic && ( count % 5 == 0)
			@page = count / 5
		elsif (count % 5 ) == 4
			@page = count / 5 
		else
			@page = count / 5 + 1
		end
	end

	def categories
		@categories = Category.all
	end
end
