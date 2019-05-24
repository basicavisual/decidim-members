# frozen_string_literal: true

module Decidim
  module Members

    class MembersController < Decidim::ApplicationController
      include Decidim::NeedsPermission

      def index
        enforce_permission_to :view, :members
        @members = MemberCollectionPresenter.new(
          organization: current_organization,
          page: params[:page].to_i,
          query: params[:q]
        ).attach_controller self
      end

      def export
        enforce_permission_to :export, :members
        users = OrganizationMembers.new(current_organization).query
        data = GenerateUserCsv.new(users).call
        send_data(
          data,
          type: 'text/csv; header=present',
          filename: 'users.csv'
        )
      end

      def show
        enforce_permission_to :view, :members
        user = UserPresenter.new current_member
        redirect_to user.profile_path, status: :moved_permanently
      end

      private

      def permission_scope
        :global
      end

      def permission_class_chain
        [ Decidim::Members::Permissions ]
      end

      def current_member
        @current_member ||= OrganizationMembers.new(current_organization).query.find params[:id]
      end

    end
  end
end
