# frozen_string_literal: true

module Decidim
  module Members
    class UpdateUserIndex < Rectify::Command

      CONFIG     = "fundaction"
      SET_WEIGHT = "setweight(to_tsvector(:config, :text), :weight)"

      def initialize(user)
        @user = user
      end

      def call
        tsvector = index_data.map do |weight, value|
          if value.present?
            @user.class.send(
              :sanitize_sql_array,
              [SET_WEIGHT, {config: CONFIG,
                            text: value,
                            weight: weight}]
            )
          end
        end.compact.join(' || ')
        if tsvector.present?
          User.where(id: @user.id).update_all "tsv = #{tsvector}"
        end
      end

      private

      # FIXME this relies on the UserPresenter patch that is part of the main
      # application
      def index_data
        presenter = Decidim::UserPresenter.new(@user)
        {
          'A' => presenter.name,
          'B' => strip_tags(presenter.about_me),
          'C' => presenter.areas_of_interest.join(' '),
          'D' => (presenter.languages || []).join(' ') + " #{presenter.country}"
        }
      end

      def strip_tags(text)
        # this leaves no whitespace for empty paragraphs / line breaks
        # ActionController::Base.helpers.strip_tags text
        Sanitize.fragment text
      end

    end
  end
end
