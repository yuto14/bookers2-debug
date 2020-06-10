class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  #Relationshipも2つに分けているのでclass_nameが使える。
  #foreign_keyは外部キーで「userのid」とforeign_keyが合致するものを持ってこれる。
  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy # フォロワー取得
  #簡単にフォローしている、されているユーザーを取得できるようにする記述
  #フォローする人(follower)は中間テーブル(Relationshipのfollower)を通じて(through)、フォローされる人(followed)と紐づく
  has_many :following_user,through: :follower,source: :followed
  #フォローされる人(followed) は中間テーブル(Relationshipのfollowed)を通じて(through)、 フォローする人(follower) と紐づく
  has_many :follower_user,through: :followed,source: :follower

#フォロー機能
  def follow(user_id) #ユーザーをフォローする
    follower.create(followed_id: user_id)
  end
  def unfollow(user_id) #ユーザーのフォローを外す
    follower.find_by(followed_id: user_id).destroy
  end
  def following?(user) #フォロー確認を行う
    following_user.include?(user)
  end
#ここまでフォロー機能

#user、book検索機能
  def self.search(search, word)
    if search == "forward_match"
        @users = User.where(['name LIKE ?', "#{word}%"])
    elsif search == "backward_match"
        @users = User.where(['name LIKE ?', "%#{word}"])
    elsif search == "perfect_match"
        @users = User.where(['name LIKE ?', "#{word}"])
    elsif search == "partial_match"
        @users = User.where(['name LIKE ?', "%#{word}%"])
    else
        @users = User.all
    end
  end
#ここまでuser、book検索機能

#住所検索機能
  include JpPrefecture
  jp_prefecture :prefecture_code #prefecture_codeはuserが持っているカラム
  def prefecture_name #postal_codeからprefecture_name(gem JpPrefectureのカラム)に変換するメソッドを用意する
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end
  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name::prefecture_name).code
  end
#ここまで住所検索機能

#住所表示機能
 geocoded_by :address
 after_validation :geocode
#上２行でaddressを登録した際にgeocoder(gem)が緯度、経度のカラムにも自動的に値を入れてくれる。
  geocoded_by :address
  def address
    "#{self.prefecture_code}" + "#{self.city}"
  end
#ここまで住所表示機能

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :books

  attachment :profile_image, destroy: false

  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}
  validates :postal_code, presence: true
  validates :city, presence: true

end