class UsersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :show]

  def index
    @users = User.order(:email).page params[:page]
  end

  def update
    user = User.find(params[:id])
    respond_to do |format|
      if user.update(user_params)
        format.json { render :json => { :message => "Success" } }
      else
        format.json { render :json => { :error => user.errors } }
      end
    end
  end

  def change_style
    current_user.style == 1 ? current_user.update(style: 0) : current_user.update(style: 1)
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
