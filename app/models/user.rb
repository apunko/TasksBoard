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

  validates :name, uniqueness: true

  before_validation :set_default_name_as_email
  after_create :gain_welcome_achievement

  paginates_per 10

  def self.from_omniauth(auth, provider)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = "#{auth.uid}@#{auth.provider}.com"
      user.name = "#{auth.uid}@#{auth.provider}"
      user.password = Devise.friendly_token[0,20]
      user.confirmed_at = DateTime.now 
    end
  end

  def rate_task?(task) 
    rate = Rating.find_by(task_id: task.id, user_id: self.id)
    rate ? true : false 
  end

  def solved?(task)
    attempt = AnswerAttempt.where(task_id: task.id, user_id: self.id, result: true)
    attempt.count > 0 ? true : false
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

  def my_comment?(comment)
    comment.user_id == self.id ? true : false 
  end

  private 
  def gain_welcome_achievement
    Achievement.add_welcom_achievement(current_user.id)
  end

  def set_default_name_as_email
    self.name = self.email if self.name == "default"
  end
end
