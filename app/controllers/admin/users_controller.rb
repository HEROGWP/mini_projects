class Admin::UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :users
	before_action :user
	before_action :check_admin
	layout "admin"
	

	def edit

		@profile = @user.profile
		if @profile == nil
			@profile = @user.build_profile
			@url = admin_users_path(:id => @user.id)
			@action = "post"
			@submit_name = "Create"
		else
			@url = admin_user_path(@user)
			@action = "patch"
			@submit_name = "Update"
		end
	end
	
	def create
		@profile = @user.build_profile(profile_params)

		if @profile.save
			flash[:notice] = "success to create"
			redirect_to edit_admin_user_path(@user)
		else
			flash[:alert] = "failed to create"
			render :action => :edit
		end
	end

	def update
		if @user.profile.update(profile_params)

 			flash[:notice] = "success to update"
			redirect_to edit_admin_user_path(@user)
		else
			flash[:alert] = "failed to update"
			render :action => :index
		end
	end

	def role_change
		if params[:role] == "admin"
			@user.update(:role => "admin")
		else
			@user.update(:role => "user")
		end
		redirect_to :back
	end


	private

	def profile_params
		params.require(:profile).permit(:nickname, :birthday, :bio)
	end

	def users
		@users = User.includes(:profile).page(params[:page]).per(5)
	end

	def user
		@user = User.includes(:profile).find(params[:id])
	end

	def users_count
		User.all.count
	end

	def check_admin
		unless current_user.admin?
		  ActiveRecord::RecordNotFound
		end
	end

end
