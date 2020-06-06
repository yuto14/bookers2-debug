class Book < ApplicationRecord
	belongs_to :user
	has_many :book_comments, dependent: :destroy
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
        favorites.where(user_id: user.id).exists?
    end

    def self.search(search, word)
    	if search == "forward_match"
            @books = Book.where(['title LIKE ?', "#{word}%"])
        elsif search == "backward_match"
            @books = Book.where(['title LIKE ?', "%#{word}"])
        elsif search == "perfect_match"
            @books = Book.where(['title LIKE ?', "#{word}"])
        elsif search =="partial_match"
            @books = Book.where(['title LIKE ?', "%#{word}%"])
    	else
    		@books = Book.all
    	end
    end
	#バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
	#presence trueは空欄の場合を意味する。
	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
