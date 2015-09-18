namespace :db do
  desc "Create basic achievements"
  task add_basic_achievements: :environment do
    make_basic_achievements    
  end
  desc "Add welcome achievement to existent users"
  task add_welcome_achievement: :environment do
    add_welcome_achievement    
  end
end

def make_achievements
  Achievement.create(title: "Welcome",
                     description: "Welcome to our site! Our team wishes you good luck!",
                     image_url: "achieves/welcome.png")
  Achievement.create(title: "The first solution",
                     description: "Wow! You solved it first!",
                     image_url: "achieves/first.png")
  Achievement.create(title: "Great solver I",
                     description: "You are awesome! You are smart! You achieved first solver level.",
                     image_url: "achieves/solverI.png")
  Achievement.create(title: "Commentator I",
                     description: "You like social life, you like to comment tasks. 
                                   You gain the first level Commentator achievemant.",
                     image_url: "achieves/commentatorI.png")
  Achievement.create(title: "Maker I",
                     description: "You made 5 tasks => you are Maker I",
                     image_url: "achieves/makerI.png")
end

def add_welcome_achievement
  users = User.all 
  users.each do |user| 
    AchievingRecord.create(user_id: user.id,
                           achievement_id: 1,
                           amount: 1)
  end
end