class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    
    if user.is_admin?
      can :manage, :all
    end

    alias_action :create, :read, :update, :delete, to: :crud

    can :crud, Post do |post|
      user == post.user
    end

    can :crud, Comment do |comment|
      user == comment.user || user == comment.post.user
    end

    can :crud, User do |u|
      user.id == u.id
    end
  end
end