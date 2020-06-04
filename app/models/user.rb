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

  def follow(user_id) #ユーザーをフォローする
    follower.create(followed_id: user_id)
  end
  def unfollow(user_id) #ユーザーのフォローを外す
    follower.find_by(followed_id: user_id).destroy
  end
  def following?(user) #フォロー確認を行う
    following_user.include?(user)
  end

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :books

  attachment :profile_image, destroy: false

  #バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :name, length: {maximum: 20, minimum: 2}
  validates :introduction, length: {maximum: 50}

end