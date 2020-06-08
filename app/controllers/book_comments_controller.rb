class BookCommentsController < ApplicationController
	def create
		@book = Book.find(params[:book_id])
		#comment = BookComment.new(book_comment_params)
		#comment.user_id = current_user.idの２行を１行にまとめた記述
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = @book.id
		comment.save
		@book_comment = BookComment.new
	end

	def destroy
		@book = Book.find(params[:book_id])
		comment = BookComment.find(params[:id])
		comment.destroy
		@book_comment = BookComment.new
	end

    private
    def book_comment_params
    	params.require(:book_comment).permit(:comment)
    end
end
