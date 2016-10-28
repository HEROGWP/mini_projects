class Admin::CategoriesController < ApplicationController
	before_action :authenticate_user!
	before_action :categories, :only => [:index, :create, :update]
	before_action :category, :only => [:update, :destroy]
	before_action :check_admin
	

	def index
		if params[:id]
			@category = Category.find(params[:id])
			@url = admin_category_path(@category)
			@action = "patch"
			@submit_name = "Update"
		else
			@category = Category.new
			@url = admin_categories_path
			@action = "post"
			@submit_name = "Create"
		end
	end
	
	def create
		@category = Category.new(category_params)
		if @category.save
			flash[:notice] = "success to create"
			@count = categories_count
			(@count % 5 == 0) ? (@page = @count / 5) : (@page = @count / 5 + 1)
			redirect_to admin_categories_path(:page => @page)
		else
			flash[:alert] = "failed to create"
			render :action => :index
		end
	end

	def update
		if @category.update(category_params)
			flash[:notice] = "success to update"
			redirect_to admin_categories_path(:page => params[:page])
		else
			flash[:alert] = "failed to update"
			render :action => :index
		end
	end

	def destroy
		if @category.topics == []
			@category.destroy
			flash[:notice] = "success to delete"
			@count = categories_count
			@page = params[:page].to_i
			if @count % 5 == 0
				@page = @page - 1
			end
		else
			flash[:alert] = "failed to delete, category topics have to nil"
		end 
		redirect_to admin_categories_path(:page => @page)
	end

	private

	def category_params
		params.require(:category).permit(:name)
	end

	def categories
		@categories = Category.page(params[:page]).per(5)
	end

	def category
		@category = Category.find(params[:id])
	end

	def categories_count
		Category.all.count
	end

	def check_admin
		unless current_user.admin?
			raise ActiveRecord::RecordNotFound
		end
	end

end
