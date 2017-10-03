# frozen_string_literal: true

Decidim.register_participatory_space(:members) do |participatory_space|
  participatory_space.engine = Decidim::Members::Engine
  participatory_space.admin_engine = Decidim::Members::AdminEngine
end
