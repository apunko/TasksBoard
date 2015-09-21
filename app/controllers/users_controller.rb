class UsersController < ApplicationController

  def index
    @users = User.order(:email).page params[:page]
  end

  def update
    user = User.find(params[:id])
    respond_to do |format|
      if user.update(user_params)
        format.html { redirect_to user, notice: 'Was successfully updated.' }
        format.json { render :json => { :message => "Success" } }
      else
        format.html { render :edit }
        format.json { render :json => { :error => user.errors } }
      end
    end
  end

  def change_style
    if current_user.style == 1
      current_user.update(style: 0)
    else
      current_user.update(style: 1)
    end
    redirect_to :back, notice: "Please reload page."
    rescue ActionController::RedirectBackError
      redirect_to root_path, notice: "Please reload page."
  end

  def show
    @user = User.find(params[:id])
  end

  private
  
  def user_params
    params.require(:user).permit(:name)
  end
end
