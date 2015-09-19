namespace :db do
  desc "Create basic achievements"
  task add_basic_achievements: :environment do
    make_basic_achievements    
  end
  desc "Add welcome achievement to existent users"
  task add_welcome_achievement: :environment do
    add_welcome_achievement    
  end
  desc "Add new achievements"
  task add_new_achievements: :environment do
    make_new_achievements    
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

def make_new_achievements
  Achievement.create(title: "Lion",
                     description: "You are the king! You are the greatest lion!",
                     image_url: "achieves/lion.png")
  Achievement.create(title: "Great solver II",
                     description: "You are awesome! You are smart! You achieved the second solver level.",
                     image_url: "achieves/solverII.png")
  Achievement.create(title: "Commentator II",
                     description: "You like social life, you like to comment tasks. 
                                   You gain the second level Commentator achievemant.",
                     image_url: "achieves/commentatorII.png")
  Achievement.create(title: "Maker II",
                     description: "You made 10 tasks => you are Maker II",
                     image_url: "achieves/makerII.png")
   Achievement.create(title: "Great solver III",
                     description: "You are awesome! You are smart! You achieved the III solver level.",
                     image_url: "achieves/solverII.png")
  Achievement.create(title: "Commentator III",
                     description: "You like social life, you like to comment tasks. 
                                   You gain the III level Commentator achievemant.",
                     image_url: "achieves/commentatorIII.png")
  Achievement.create(title: "Maker III",
                     description: "You made 20 tasks => you are Maker III",
                     image_url: "achieves/makerIII.png")
  Achievement.create(title: "Great solver IV",
                     description: "You are awesome! You are smart! You achieved the IV solver level.",
                     image_url: "achieves/solverIV.png")
  Achievement.create(title: "Commentator IV",
                     description: "You like social life, you like to comment tasks. 
                                   You gain the IV level Commentator achievemant.",
                     image_url: "achieves/commentatorIV.png")
  Achievement.create(title: "Maker IV",
                     description: "You made 50 tasks => you are Maker IV",
                     image_url: "achieves/makerIV.png")
  Achievement.create(title: "Great solver V",
                     description: "You are awesome! You are smart! You achieved the V solver level.",
                     image_url: "achieves/solverV.png")
  Achievement.create(title: "Commentator V",
                     description: "You like social life, you like to comment tasks. 
                                   You gain the V level Commentator achievemant.",
                     image_url: "achieves/commentatorV.png")
  Achievement.create(title: "Maker V",
                     description: "You made 100 tasks => you are Maker V",
                     image_url: "achieves/makerV.png")
end

def add_welcome_achievement
  users = User.all 
  users.each do |user| 
    AchievingRecord.create(user_id: user.id,
                           achievement_id: 1,
                           amount: 1)
  end
end