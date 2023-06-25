# frozen_string_literal: true

module Decidim
  module Members
    class MemberCollectionPresenter < Rectify::Presenter
      attribute :organization, Decidim::Organization
      attribute :page, Integer
      attribute :params, ActionController::Parameters

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
        if params[:filter].present?
          filters = set_params
          @org_members ||= MemberSearch.new(organization, filters).query
        else
          @org_members ||= MemberSearch.new(organization, nil).query
        end
      end

      def org_members
        if params[:filter].present?
          session[:members_ordering] = nil
          unsorted_org_members
        else
          unsorted_org_members.reorder Hash[[session_ordering]]
        end
      end

      def session_ordering
        session[:members_ordering] ||= [[:id, :name, :email], [:asc, :desc]].map(&:sample)
      end

      def set_params
        {
          search_text: params[:filter][:search_text],
          working_groups: params[:filter][:working_groups],
          areas_of_interest: params[:filter][:areas_of_interest]
        }
      end

    end
  end
end


