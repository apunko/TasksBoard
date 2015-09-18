namespace :db do
  desc "make statistic of existent data"
  task make_statistic: :environment do
    make_users_statistic   
  end
end

def make_users_statistic
  users = User.all 
  users.each do |user|
    user.answer_attempts.each do |attempt|
      if attempt.result == true
        user.rate += Task.find(attempt.task_id).level 
      end
    end
    user.save
  end
end


