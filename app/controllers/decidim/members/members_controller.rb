# frozen_string_literal: true

module Decidim
  module Members

    class MembersController < Decidim::ApplicationController

      def index
        authorize! :read, Decidim::User
        @members = MemberCollectionPresenter.new(
          organization: current_organization,
          page: params[:page].to_i,
          query: params[:q]
        ).attach_controller self
      end

      def show
        authorize! :read, Decidim::User
        user = UserPresenter.new current_member
        redirect_to user.profile_path, status: :moved_permanently
      end

      private

      def current_member
        @current_member ||= OrganizationMembers.new(current_organization).query.find params[:id]
      end

    end
  end
end
