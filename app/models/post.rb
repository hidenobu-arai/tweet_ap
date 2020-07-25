class Post < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 140}}
  validates :user_id, {presence: true}
# Postにユーザー関数を定義して、一覧でユーザー情報と紐付けて使えるようにする
  def user
    return User.find_by(id: self.user_id)
  end



end
