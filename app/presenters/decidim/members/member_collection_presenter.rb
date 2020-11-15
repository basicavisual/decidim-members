# frozen_string_literal: true

module Decidim
  module Members
    class MemberCollectionPresenter < Rectify::Presenter
      attribute :organization, Decidim::Organization
      attribute :page, Integer
      attribute :query, String

      def count
        unsorted_org_members.count
      end

      def render_pagination
        paginate collection, theme: "decidim"
      end

      def render_current_page
        render collection: decorated_members, partial: 'user'
      end

      private


      def collection
        @collection ||= org_members.page(page).per(12)
      end

      def decorated_members
        collection.map{ |m|
          ::Decidim::UserPresenter.new(m)
        }
      end

      def unsorted_org_members
        @org_members ||= begin
          scope = if query.present?
            r = Decidim::Search.call query, organization, resource_type: "Decidim::User"
            r.dig :ok, "Decidim::User", :results
          else
            OrganizationMembers.new(organization).query
          end
          scope
        end
      end

      def org_members
        if query.present?
          session[:members_ordering] = nil
          unsorted_org_members
        else
          unsorted_org_members.reorder Hash[[session_ordering]]
        end
      end

      def session_ordering
        session[:members_ordering] ||= [[:id, :name, :email], [:asc, :desc]].map(&:sample)
      end

    end
  end
end


