namespace :db do
  desc "make statistic of existent data"
  task make_statistic: :environment do
    make_users_statistic   
  end
end

def make_users_statistic
  users = User.all 
end


