# frozen_string_literal: true

module Decidim
  module Members
    class MemberCollectionPresenter < Rectify::Presenter
      attribute :organization, Decidim::User
      attribute :page, Integer

      def count
        org_members.count
      end

      def render_pagination
        paginate collection, theme: "decidim"
      end

      def render_current_page
        render collection: decorated_members, partial: 'member'
      end

      private


      def collection
        @collection ||= org_members.query.page(page).per(12)
      end

      def decorated_members
        collection.map{ |m|
          MemberPresenter.new(user: m).attach_controller controller
        }
      end

      def org_members
        @org_members ||= OrganizationMembers.new(organization)
      end

    end
  end
end


