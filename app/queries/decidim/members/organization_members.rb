# frozen_string_literal: true

module Decidim
  module Members
    class OrganizationMembers < Rectify::Query
      def initialize(organization)
        @organization = organization
      end

      def query
        @organization.users.not_deleted.no_active_invitation.not_blocked.order(name: :asc)
      end
    end
  end
end

