# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    case user.user_type
    when 'manager'
      can :manage, Project
      can :manage, Bug
      can :manage, User # Managers can manage users (create, read, update, destroy)
    when 'developer'
      can :read, Project
      can :read, Bug
      can :update, Bug, developer_id: user.id # Developer can update only the bugs assigned to them
    when 'qa'
      can :read, Project
      can :create, Bug # QA can create new bugs
      can :update, Bug, creator_id: user.id # QA can update only the bugs they created
    end
    # Define abilities for the user here. For example:
    #
    #   return unless user.present?
    #   can :read, :all
    #   return unless user.admin?
    #   can :manage, :all
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, published: true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/define_check_abilities.md
  end
end
