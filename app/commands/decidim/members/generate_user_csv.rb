# frozen_string_literal: true

require 'csv'

module Decidim
  module Members
    class GenerateUserCsv < Rectify::Command

      def initialize(scope)
        @scope = scope
      end

      HEADERS = [
        'Id','Email','Name','Nickname', 'Invited At', 'Invited By'
      ].freeze

      def call
        CSV.generate(col_sep: ';', encoding: 'UTF-8') do |csv|
          csv << HEADERS
          @scope.find_in_batches do |group|
            group.each do |user|
              csv << [
                user.id, user.email, user.name, user.nickname,
                format_date(user.invitation_sent_at),
                user.invited_by_id
              ]
            end
          end
        end
      end

      def format_date(date)
        I18n.l date if date
      end

    end
  end
end
