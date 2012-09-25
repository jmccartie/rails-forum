class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    if user.admin?
        can :manage, :all
    elsif user.persisted?
      can :read, :all
      can :manage, Post, :user_id => user.id
      can :create, Post
      can :manage, Topic, :user_id => user.id
      can :manage, User, :id => user.id
    else
      can :read, :all
    end

  end
end
