class Relationship < ApplicationRecord
	#フォローする人(follower)もされる人(followed)もUserモデルで
    #本来、followerやfollowedといったモデルは存在しないが
	#class_nameをつけることで関連先のモデルを参照する際の名前を変更できる
	belongs_to :follower, class_name: "User"
	belongs_to :followed, class_name: "User"
end
