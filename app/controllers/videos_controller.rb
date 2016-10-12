class VideosController < ApplicationController
	before_action :authenticate_user!, :except => [:index]
	before_action :videos
	before_action :video, :only => [:update, :destroy]
	
	def index
		if params[:id]
			@video = Video.find(params[:id])
			@submit_name = "Update"
		else
			@video = Video.new
			@submit_name = "Create"
		end			
		set_pagination
	end

	def create
		@video = Video.new(video_params)
		@video[:random] = SecureRandom.hex(5)
		@video[:times] = 0
		if @video.save
			flash[:notice] = "success to create"
			@count = videos_count
			(@count % 5 == 0) ? (@page = @count / 5) : (@page = @count / 5 + 1)
			set_pagination
			redirect_to videos_path(:page => @page)
		else
			flash[:alert] = "failed to create"
			set_pagination
			render :action => :index
		end
	end

	def update
		if @video.update(video_params)
			flash[:notice] = "success to update"
			set_pagination
			redirect_to videos_path(:page => params[:page])
		else
			flash[:alert] = "failed to update"
			set_pagination
			render :action => :index
		end
	end

	def destroy
		set_page(@video)
		@video.destroy
		flash[:notice] = "success to delete"
		set_pagination
		redirect_to videos_path(:page => @page)
	end

	def pass_url
		@video = Video.find_by(:random => params[:random])
		@address_url = @video.url_address
		@video.update(:times => @video.times+1)
		redirect_to @address_url
	end

	private

	def video_params
		params.require(:video).permit(:name, :description, :url_address)
	end

	def videos
		@videos = Video.all
	end

	def set_pagination
		@videos = @videos.page(params[:page]).per(5)
	end

	def video
		@video = Video.find(params[:id])
	end

	def videos_count
		Video.all.count
	end

	def set_page(video)
		count = @videos.find_index(video) + 1
		if @videos.last == video && ( count % 5 == 1)
			@page = count / 5
		elsif (count % 5 ) == 0
			@page = count / 5 
		else
			@page = count / 5 + 1
		end
	end
end
