class UsersController < ApplicationController
before_action :authenticate_users , {only: [:index, :show, :edit, :update]}
before_action :forbid_login_user , {only: [:new, :login, :create, :login_form]}
before_action :ensure_correct_user , {only: [:edit, :update]}

  def ensure_correct_user
    if @current_user_id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/posts/index")
    end
  end


  def index
    @users = User.all
  end


  def show
    @user = User.find_by(id: params[:id])
    @posts = Post.where(user_id: @user.id)
  end

  def new 
    @user = User.new
  end

  def create 
    @user = User.new(
            name: params[:name], 
            email: params[:email],
            password: params[:password],
            image_name: "default_user.jpg"
    )
    if @user.save
      flash[:notice] = "ユーザー登録が完了しました"
      session[:user_id] = @user.id
      redirect_to("/users/index")
    else
      render("users/new")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update 
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
      # 入力されたイメージは文字列で表現されているので、それを読み込むための関数
    end

    if @user.save 
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/index")
    else 
      render("users/edit")
    end
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id) 
  end


  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    #ハッシュ化したパスワードを制御するためにauthenticate関数を利用する
    if @user && @user.authenticate(params[:password])
      flash[:notice] = "ログインしました"
      session[:user_id] = @user.id
      redirect_to("/posts/index")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end
end
