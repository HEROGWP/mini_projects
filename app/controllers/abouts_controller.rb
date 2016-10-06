class AboutsController < ApplicationController

	def index
		@users_count = User.all.count
		@topics_count = Topic.all.count
		@comments_count = Comment.all.count

	end
end
