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
			redirect_to videos_path
		else
			flash[:alert] = "failed to create"
			render :action => :index
		end
	end

	def update
		if @video.update(video_params)
			flash[:notice] = "success to update"
			redirect_to videos_path
		else
			flash[:alert] = "failed to update"
			render :action => :index
		end
	end

	def destroy
		@video.destroy
		flash[:notice] = "success to delete"
		redirect_to videos_path
	end

	private

	def video_params
		params.require(:video).permit(:name, :description, :url_address)
	end

	def videos
		@videos = Video.all
	end

	def video
		@video = Video.find(params[:id])
	end
end
