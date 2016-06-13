class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
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

  def edit_params
     params.require(:user).permit(:name, :email, :prof, :location)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, 
                                 :password_confirmation)
  end
end
