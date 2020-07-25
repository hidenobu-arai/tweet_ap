class PostsController < ApplicationController
  # ログインしているユーザーのみ許可する
  before_action :authenticate_users
  # 同じユーザーの投稿のみ許可する
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}


  # ensure_correct_userメソッドを定義してください
  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end



  def index
    @posts = Post.all.order(created_at: :desc)
    # ＠マークが全角でエラー
  end

  def show 
    @post = Post.find_by(id: params[:id])
    @likes_count = Like.where(post_id: @post.id).count
    #URLに設定される:idがparams[:id]として定義される
    # @user = User.find_by(id: @post.user_id)
    # showページにユーザー情報を出すために、@userを定義
    # 上記はpostクラスにuserインスタンスを追加することで省略している
  end

  def new
    @post = Post.new
    # 新規投稿でエラーになったとき再入力させたいが、
    # これを定義しておかないとエラーになる
  end

  def create
    @post = Post.new(content: params[:content], user_id: @current_user.id)
    if @post.save
      flash[:notice] = "投稿を作成しました"
      redirect_to("/posts/index")
    else
      render("posts/new")
    end
  end

  def edit 
    @post = Post.find_by(id:params[:id])
  end

  def update
    @post = Post.find_by(id: params[:id])
    @post.content = params[:content]
    if @post.save
      flash[:notice] = "投稿を編集しました"
      redirect_to("/posts/index")
    else
      render("posts/edit")
      #renderはURLではなくアクション名
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:notice] = "投稿を削除しました"
    redirect_to("/posts/index")
    # redirect_toを忘れると処理が止まる
  end


end
