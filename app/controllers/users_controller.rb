class UsersController < ApplicationController
	before_action :baria_user, only: [:update, :edit]

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def index
  	@users = User.all
  	@book = Book.new
    @user = current_user

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
  		redirect_to user_path(@user), notice: "successfully updated user!"
  	else
  		render "edit"
  	end
  end
end
  private
  def user_params
  	params.require(:user).permit(:name, :introduction, :profile_image)
  end
  #url直接防止　メソッドを自己定義してbefore_actionで発動。
   def baria_user
  	unless params[:id].to_i == current_user.id
  		redirect_to user_path(current_user)
  	end
   end
end
