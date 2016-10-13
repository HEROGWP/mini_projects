class ProfilesController < ApplicationController
	before_action :authenticate_user!

	def show
		@profile = Profile.find(params[:id])
		@topics = @profile.user.topics
		@comments = @profile.user.comments.includes(:topic)
	end
	
	def create
		@profile = current_user.build_profile(profile_params)
		
		if @profile.save
			flash[:notice] = "success to create"
			redirect_to profile_path(:id => @profile.id)
		else
			flash[:alert] = "failed to create"
			render :action => :new
		end
	end

	def edit
		@profile = current_user.profile
		@url = profile_path
		if @profile
			@action = "patch"
			@submit_name = "Update"
		else
			@profile = current_user.build_profile
			@action = "post"
			@submit_name = "Create"
		end
	end

	def update
		@profile = current_user.profile

		if @profile.update(profile_params)
			flash[:notice] = "success to update"
			redirect_to profile_path(:id => @profile.id)
		else
			flash[:alert] = "failed to update"
			render :action => :edit
		end
	end

	def likes
		@like_topics = current_user.like_topics
	end

	private

	def profile_params
		params.require(:profile).permit(:nickname, :birthday, :bio)
	end	
end
