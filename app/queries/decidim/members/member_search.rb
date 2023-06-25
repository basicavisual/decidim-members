# frozen_string_literal: true

module Decidim
  module Members
    class MemberSearch < Rectify::Query
      def initialize(organization, filters)
        @organization = organization
        @filters = filters
        unless @filters.nil?
          @search_text = filters[:search_text] 
          @working_groups = filters[:working_groups] 
          @areas_of_interest = filters[:areas_of_interest] 
        end
      end

      def query
        search = active_users
        unless @filters.nil?
          search = search_text(search) if @search_text.present?
          search = working_groups_only(search) if @working_groups.present? && (@working_groups != "all")
          search = areas_of_interest_only(search) if @areas_of_interest.present? && (@areas_of_interest != "all")
        end

        search
      end

      private

      def active_users
        @organization.users.not_deleted.no_active_invitation.order(name: :asc)
      end

      def search_text(search)
        search.where("name ILIKE ?", "%" + Decidim::User.sanitize_sql_like(@search_text)  + "%")
      end

      def working_groups_only(search)
        search.where("profile -> 'working_groups' ? :working_groups", working_groups: @working_groups)
      end

      def areas_of_interest_only(search)
        search.where("profile -> 'areas_of_interest' ? :areas_of_interest", areas_of_interest: @areas_of_interest)
      end
    end
  end
end