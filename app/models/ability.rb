class Ability
  include CanCan::Ability

  def initialize(user, controller_namespace)
    if controller_namespace != 'Admin'
      can :read, :all

      if user
        can [:create, :update, :destroy], Inquiry, user_id: user.id
        cannot :read, Inquiry do |i|
          i.user_id != user.id
        end
      end
    else
      if user.role == 'super_admin'
        can :manage, :all
      elsif user.role == 'admin'
        can :manage, :all
        cannot [:create, :destroy], Board
        cannot :manage, Setting
      end
    end
  end
end
