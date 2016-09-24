class VideosController < ApplicationController
	before_action :videos, :only => [:index, :create, :update]
	before_action :video, :only => [:update, :destroy]
	
	def index
		if params[:id]
			@video = Video.find(params[:id])
			@submit_name = "Update"
		else
			@video = Video.new
			@submit_name = "Create"
		end			
	end

	def create
		@video = Video.new(video_params)

		if @video.save
			flash[:notice] = "success to create"
			@count = videos_count
			(@count % 5 == 0) ? (@page = @count / 5) : (@page = @count / 5 + 1)
			redirect_to videos_path(:page => @page)
		else
			flash[:alert] = "failed to create"
			render :action => :index
		end
	end

	def update
		if @video.update(video_params)
			flash[:notice] = "success to update"
			redirect_to videos_path(:page => params[:page])
		else
			flash[:alert] = "failed to update"
			render :action => :index
		end
	end

	def destroy
		@video.destroy
		flash[:notice] = "success to delete"
		@count = videos_count
		@page = params[:page].to_i
		if @count % 5 == 0
			@page = @page - 1
		end 
		redirect_to videos_path(:page => @page)
	end

	private

	def video_params
		params.require(:video).permit(:name, :description, :url_address)
	end

	def videos
		@videos = Video.page(params[:page]).per(5)
	end

	def video
		@video = Video.find(params[:id])
	end

	def videos_count
		Video.all.count
	end
end
