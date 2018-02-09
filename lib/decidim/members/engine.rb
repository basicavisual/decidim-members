# frozen_string_literal: true

require "rails"
require "active_support/all"

require "decidim/core"
require "sanitize"
require_dependency "decidim/members/patches/update_account_patch"

module Decidim
  module Members
    # Decidim's Members Rails Engine.
    class Engine < ::Rails::Engine
      isolate_namespace Decidim::Members

      routes do
        resources(:members, only: [:index, :show], path: "members") do
          collection do
            get :export
          end
        end
      end

      initializer "decidim_assemblies.inject_abilities_to_user" do |_app|
        Decidim.configure do |config|
          config.abilities += [
            "Decidim::Members::Abilities::UserAbility",
            "Decidim::Members::Abilities::AdminAbility",
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

      # TODO looks like we lose this patch in dev mode after code reloads :()
      initializer "patch core classes" do
        Decidim::Members::Patches::UpdateAccountPatch.apply
      end
    end
  end
end
