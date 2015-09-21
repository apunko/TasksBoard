class Ability
  include CanCan::Ability

  def initialize(user)
    if user
      can :manage, :all
      cannot :destroy, Comment do |comment|
        !(comment.user_id == user.id)
      end
      cannot [:destroy, :update], Task do |task|
        !(task.user_id == user.id)
      end
      cannot [:destroy, :update, [:edit]], Answer do |answer|
        !(answer.user_id == user.id)
      end
    else
      can :read, :all
    end
  end
end
