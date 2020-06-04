class RelationshipsController < ApplicationController
	def create
		current_user.follow(params[:id])
		redirect_back(fallback_location: root_path)
	end

	def destroy
		current_user.unfollow(params[:id])
		redirect_back(fallback_location: root_path)
	end

	def follows
		@user = User.find(params[:id])
	end

	def followers
		@user = User.find(params[:id])
	end
end
