# frozen_string_literal: true

require 'csv'

module Decidim
  module Members
    class GenerateUserCsv

      def initialize(scope)
        @scope = scope
      end

      HEADERS = [
        'Id','Email','Name','Nickname', 'Invited At', 'Invited By', 'Country'
      ].freeze

      def call
        CSV.generate(col_sep: ';', encoding: 'UTF-8') do |csv|
          csv << HEADERS
          @scope.find_each do |user|
            csv << [
              user.id, user.email, user.name, user.nickname,
              format_date(user.invitation_sent_at),
              invited_by(user), get_country_code(user)
            ]
          end
        end
      end

      def format_date(date)
        I18n.l date if date
      end

      def invited_by(user)
        if user.invited_by
          user.invited_by.nickname
        else
          "N/A"
        end
      end

      def get_country_code(user)
        if user.profile.nil?
          "No profile"
        else
          ISO3166::Country[user.profile['country']]
        end
      end
    end
  end
end
