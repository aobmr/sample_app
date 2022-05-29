class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/:id
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
    #debugger
   # @user = User.first
  end
  
  #GET /users/new
  def new
    @user = User.new
  end
  
  def create
    #User.create(params[:user])
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user # user_path
      #@userからやりたいことをrailsが推測して展開してくれる
      #redilect_to => GET /users/#{@user.id} にリクエストを飛ばす
      #redilect_to user_path(@user)
      #-> #redilect_to user_path(@user.id) へ
      #-> redilect_to user_path(1)
      # => /users/1
      #success(valid params)
    else
      # Failure
      render 'new'
    end
  end
  
  
  def edit
    @user = User.find(params[:id])
  end
  
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  
  private #より下のものはこのファイルからしかアクセスできない
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
    
  # def logged_in_user
  #   unless logged_in?
  #     store_location
  #     flash[:danger] = "Please log in."
  #     redirect_to login_url
  #   end
  # end
  
  #正しいユーザかどうか確認
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  
  
  #管理者かどうか確認
  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
  

end
