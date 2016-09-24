class VideosController < ApplicationController
	before_action :videos, :only => [:new, :edit]
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
