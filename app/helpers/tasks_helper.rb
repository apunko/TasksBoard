module TasksHelper
  def my_task?(task, user)
    begin
      user.tasks.find(task.id)
    rescue 
      false
    end
  end

  def current_task_id
    session[:current_task_id]
  end
end
