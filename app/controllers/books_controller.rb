class BooksController < ApplicationController
  before_action :baria_user, only: [:update, :edit]

  def show
  	@book = Book.find(params[:id])
    @user = @book.user
    @book1 = Book.new
    @book_comment = BookComment.new
  end

  def index
  	@books = Book.all
    @book = Book.new
  end


  def create
  	@book = Book.new(book_params)
    @book.user_id = current_user.id
  	if @book.save
  		redirect_to @book, notice: "successfully created book!"
  	else
  		@books = Book.all
  		render 'index'
  	end
  end

  def edit
  	@book = Book.find(params[:id])
  end



  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  		redirect_to @book, notice: "successfully updated book!"
  	else
  		render "edit"
  	end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path, notice: "successfully delete book!"
  end

  private

  def book_params
  	params.require(:book).permit(:title, :body)
  end

  def baria_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
    redirect_to books_path
    end
  end

end
