# rails g migration add_user_id_to_posts で生成できるファイル

class AddUserIdToPosts < ActiveRecord::Migration[6.0]

  def change
      add_column :posts, :user_id, :integer
  end
end
