class VideosController < ApplicationController
	before_action :videos, :only => [:new, :create, :edit, :update]
	before_action :video, :only => [:edit, :update, :destroy]
	
	def new
		@video = Video.new
	end

	def create
		@video = Video.new(video_params)

		if @video.save
			redirect_to new_video_path
		else
			render :new
		end
	end

	def edit
		
	end

	def update
		if @video.update(video_params)
			redirect_to new_video_path
		else
			render :edit
		end
	end

	def destroy
		
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
