class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_url, notice: exception.message
  end
  rescue_from ActiveRecord::RecordNotFound do |exception|
    redirect_to main_app.root_url, notice: exception.message
  end
  include CanCan::ControllerAdditions
  include ApplicationHelper
  include TasksHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, :only => [:search]
  before_action :authenticate_user!

  def home
  end

  def download_image
    Achievement.generate_image_of_achievements(current_user)
    send_file("#{Rails.root}/app/assets/images/output.jpg",
              filename: "your_custom_file_name.jpg",
              type: "image/jpeg")
  end

  def search
    @tasks = generate_tasks_by_query(params[:q])
  end
end
