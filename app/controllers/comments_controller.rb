class CommentsController < ApplicationController
  after_action :check_next_achievements, only: :create

  def create
    comment = Comment.new(comment_params)
    @task = Task.find(current_task_id)
    respond_to do |format|
      if comment.save
        format.html { redirect_to @task }
      else
        flash[:error] = comment.errors.messages
        format.html { redirect_to @task }
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
    Achievement.check_new_comments_achievements(current_user)
  end

  def comment_params
    params_hash = params.require(:comment).permit(:message)
    params_hash[:task_id] = current_task_id
    params_hash[:user_id] = current_user.id
    params_hash
  end
end
