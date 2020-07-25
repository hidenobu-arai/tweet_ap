class User < ApplicationRecord
  # has_secure_passwordメソッドを追加してください
  has_secure_password

  # nameカラムに関するバリデーションを作成してください
  validates :name, {presence: true}
  # emailカラムに関するバリデーションを作成してください
  validates :email, {presence: true, uniqueness: true}
  # passwordカラムに関するバリデーションを作成してください
  # validates :password, {presence: true}

  def posts
    return Post.where(user_id: self.id)
  end

end
