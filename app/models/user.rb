class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:facebook, :twitter, :vkontakte]
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  has_many :tasks
  has_many :answer_attempts
  has_many :comments
  has_many :ratings
  has_many :achieving_records
  has_many :achievements, through: :achieving_records

  after_create :gain_welcome_achievement

  def self.from_omniauth(auth, provider)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "#{auth.uid}@#{auth.provider}.com"
      user.password = Devise.friendly_token[0,20]
      user.confirmed_at = DateTime.now 
    end
  end

  def get_achievements
    achievements = []
    self.achieving_records.each do |record|
      record_achievement = Achievement.find(record.achievement_id)
      record.amount.times { achievements << record_achievement }
    end  
    achievements
  end

  def update_rate(attempt)
    if attempt.result == true
      self.rate += Task.find(attempt.task_id).level
      self.save
    end
  end

  private 

  def gain_welcome_achievement
    AchievingRecord.create(user_id: current_user.id, achievement_id: 1, amount: 1)
  end
end
