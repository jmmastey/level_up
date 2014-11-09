class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Guest.new
    can :manage, :all if user.admin?
  end
end
