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
			redirect_to videos_path
		else
			render videos_path
		end
	end

	def update
		if @video.update(video_params)
			redirect_to videos_path
		else
			render videos_path
		end
	end

	def destroy
		@video.destroy
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
