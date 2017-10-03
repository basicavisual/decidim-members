# frozen_string_literal: true

module Decidim
  module Members

    class MembersController < Decidim::ApplicationController

      def index
        authorize! :read, Decidim::User
        @members = MemberCollectionPresenter.new(
          organization: current_organization,
          page: params[:page].to_i
        ).attach_controller self
      end

      def show
        authorize! :read, current_member
        @member = MemberPresenter.new(user: current_member).attach_controller self
      end

      private

      def current_member
        @current_member ||= OrganizationMembers.new(current_organization).query.find params[:id]
      end

    end
  end
end
