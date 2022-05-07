class UsersController < ApplicationController
  # GET /users/:id
  def show
    @user = User.find(params[:id])
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
  
  private #より下のものはこのファイルからしかアクセスできない
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
