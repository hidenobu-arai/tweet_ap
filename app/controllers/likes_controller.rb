class LikesController < ApplicationController
  before_action :authenticate_users

  def create
    @like = Like.new(user_id: @current_user.id, post_id: params[:post_id] )
    @like.save
    redirect_to("/posts/#{params[:post_id]}")
    # リダイレクト処理をしないと、その場所でボタンを押し続けることができるため、データが増え続ける
  end

  def destroy
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id] )
    @like.destroy    
    redirect_to("/posts/#{params[:post_id]}")
    # リダイレクト処理をしないと、その場所でボタンを押し続けることができるため、データが増え続ける
  end
end
