class CommentsController < ApplicationController
  include TasksHelper

  after_action :check_next_achievements, only: :create

  def create
    comment = Comment.new(comment_params)
    @task = Task.find(current_task_id)
    respond_to do |format|
      if comment.save
        format.html { redirect_to @task }
      else
        format.html { redirect_to @task, notice: "Can't add comment" }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @task = Task.find(current_task_id)
    redirect_to @task
  end

  private

    def check_next_achievements
      if current_user.comments.count == 5
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 4, amount: 1)
      end
      if current_user.comments.count == 10
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 8, amount: 1)
      end
      if current_user.comments.count == 20
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 11, amount: 1)
      end
      if current_user.comments.count == 50
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 14, amount: 1)
      end
      if current_user.comments.count == 100
        AchievingRecord.find_or_create_by(user_id: current_user.id, achievement_id: 17, amount: 1)
      end
    end

    def comment_params
      params_hash = params.require(:comment).permit(:message)
      params_hash[:task_id] = current_task_id
      params_hash[:user_id] = current_user.id
      params_hash
    end
end
