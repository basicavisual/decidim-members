# frozen_string_literal: true

module Decidim
  module Members
    module Abilities
      # Defines the base abilities related to members for any user.
      # Intended to be used with `cancancan`.
      class UserAbility
        include CanCan::Ability

        def initialize(user, context)
          @user = user
          @context = context

          define_abilities if user?
        end

        def user?
          @user.is_a? Decidim::User
        end

        def define_abilities
          can :read, Decidim::User
        end
      end
    end
  end
end
