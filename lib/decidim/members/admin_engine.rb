# frozen_string_literal: true

require "rails"
require "active_support/all"

require "decidim/core"

module Decidim
  module Members
    # Decidim's Members Rails Admin Engine.
    # There is nothing to administer, it's 'only provided since Decidim
    # requires it.
    class AdminEngine < ::Rails::Engine
      isolate_namespace Decidim::Members

      paths["db/migrate"] = nil

      routes do
      end

    end
  end
end

