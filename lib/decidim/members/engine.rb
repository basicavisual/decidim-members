# frozen_string_literal: true

require "rails"
require "active_support/all"

require "decidim/core"

module Decidim
  module Members
    # Decidim's Members Rails Engine.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Members

      routes do
        resources :members, only: [:index, :show], path: "members"
      end

      initializer "decidim_assemblies.inject_abilities_to_user" do |_app|
        Decidim.configure do |config|
          config.abilities += [
            "Decidim::Members::Abilities::UserAbility",
          ]
        end
      end

      initializer "decidim_members.menu" do
        Decidim.menu :menu do |menu|
          menu.item I18n.t("menu.members", scope: "decidim"),
                    decidim_members.members_path,
                    position: 2.5,
                    active: :inclusive
        end
      end
    end
  end
end
