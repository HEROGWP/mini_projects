class UsersController < ApplicationController
	before_action :authenticate_user!
	before_action :set_user, :only => [:add]
	
	def index
		if current_user.friends
			@friends = current_user.friendships.confirm.map(&:friend)
		else
			@friends = []
		end
	end

	def add
		unless @user == current_user
			@friend = current_user.friendships.create(:friend_id => params[:id], :relationship => "confirming")
		end
		redirect_to :back
	end

	def destroy
		
	end

	def change_relationship
		@friend = current_user.inverse_friendships.find_by_user_id(params[:id])
		@friend.update(:relationship => params[:relationship])
		if params[:relationship] == "confirm"
			@friend = current_user.friendships.create(:friend_id => params[:id], :relationship => "confirm")
		end
		redirect_to :back
	end

	def who_add_me
		if current_user.friends
			@whose = current_user.inverse_friendships.confirming.map(&:user)
			@whose_ignore = current_user.inverse_friendships.ignore.map(&:user)
		else
			@whose = []
			@whose_ignore = []
		end
	end

	private

	def set_user
		@user = User.find(params[:id])
	end
end
