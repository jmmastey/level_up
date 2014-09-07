class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :manage, :all if user.has_role? :admin
  end
end
