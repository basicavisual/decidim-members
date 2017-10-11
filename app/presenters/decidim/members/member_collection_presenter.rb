# frozen_string_literal: true

module Decidim
  module Members
    class MemberCollectionPresenter < Rectify::Presenter
      attribute :organization, Decidim::User
      attribute :page, Integer
      attribute :query, String

      def count
        unsorted_org_members.count
      end

      def render_pagination
        paginate collection, theme: "decidim"
      end

      def render_current_page
        render collection: decorated_members, partial: 'member'
      end

      private


      def collection
        @collection ||= org_members.page(page).per(12)
      end

      def decorated_members
        collection.map{ |m|
          MemberPresenter.new(user: m).attach_controller controller
        }
      end

      def unsorted_org_members
        @org_members ||= begin
          scope = OrganizationMembers.new(organization).query
          if query.present?
            scope = FilteredMembers.for(query, scope)
          end
          scope
        end
      end

      def org_members
        if query.present?
          users = Decidim::User.table_name
          unsorted_org_members.
            select("#{users}.*, ts_rank(#{users}.tsv, query, 1|32) as score").
            order('score ASC')
        else
          unsorted_org_members.order name: :asc

        end
      end

    end
  end
end


