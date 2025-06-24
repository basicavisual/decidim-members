# frozen_string_literal: true

require "decidim/members/engine"

module Decidim
  module Members
    # Your code goes here...
  end
end

# Engines to handle logic unrelated to participatory spaces or components
Decidim.register_global_engine(
  :decidim_members, # this is the name of the global method to access engine routes
  Decidim::Members::Engine,
  at: "/"
)