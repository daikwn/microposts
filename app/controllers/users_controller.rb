class UsersController < ApplicationController
  before_action :authenticate_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def followings
    @user = User.find(params[:followed_id])
  end
  
  def followers
    @user = User.find(params[:follower_id])
　end
　
　def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(edit_params)
       redirect_to @user
      # 更新に成功したときの処理
    else
      render 'edit'
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  private

  def edit_params
     params.require(:user).permit(:name, :email, :prof, :location)
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
  
  def authenticate_user
      @user = User.find(params[:id])
      if @user != current_user
         redirect_to root_path
      end
  end
  
end