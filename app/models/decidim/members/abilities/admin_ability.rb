# frozen_string_literal: true

module Decidim
  module Members
    module Abilities
      # Defines the base abilities related to members for admins.
      # Intended to be used with `cancancan`.
      class AdminAbility < Decidim::Abilities::AdminAbility

        def define_abilities
          can :export, :users
        end
      end
    end
  end
end

