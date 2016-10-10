class FavoritesController < ApplicationController
	before_action :authenticate_user!

	def show
		@favorites = current_user.favorites.includes(:topic)
	end

	def create
		@favorite = current_user.favorites.build(:topic_id => params[:topic_id])
		if @favorite.save
			flash[:notice] = "success add to favorites"
		else
			flash[:alert] = "faild to create"
		end
		redirect_to :back
	end

	def destroy
		@favorite = current_user.favorites.find_by(:topic_id => params[:topic_id])
		@favorite.destroy
		flash[:notice] = "success remove to favorites"
		redirect_to :back
	end
end
