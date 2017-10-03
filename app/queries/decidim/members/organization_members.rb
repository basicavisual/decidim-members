# frozen_string_literal: true

module Decidim
  module Members
    class OrganizationMembers < Rectify::Query
      def initialize(organization)
        @organization = organization
      end

      def query
        @organization.users.no_active_invitation.order(name: :asc)
      end
    end
  end
end

