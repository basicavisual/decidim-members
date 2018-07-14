module Decidim
  module Members
    class Permissions < Decidim::DefaultPermissions
      def permissions

        unless user and user.is_a?(Decidim::User)
          permission_action.disallow!
          return permission_action
        end

        unless permission_action.subject == :members
          return permission_action
        end

        case permission_action.action
        when :view
          permission_action.allow!
        when :export
          permission_action.allow! if user.admin?
        end

        permission_action
      end
    end
  end
end
