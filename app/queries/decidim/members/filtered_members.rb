# frozen_string_literal: true

module Decidim
  module Members

    class FilteredMembers < Rectify::Query


      class QueryBuilder
        WEIGHTS = %w(A B C D)

        def initialize(tokens, options = {})
          @tokens = tokens
          @operator = options[:all_words] ? ' & ' : ' | '
        end

        def to_sql
          # sql to create the query vector that is matched against the tsv
          ActiveRecord::Base.send :sanitize_sql_array, [
            "to_tsquery(:config, :query) query",
            config: UpdateUserIndex::CONFIG, query: searchable_query
          ]
        end

        private

        def sanitized_tokens
          Array(@tokens).map do |token|
            token.to_s.split(/[^[:alnum:]\*]+/).reject(&:blank?)
          end.flatten
        end

        def searchable_query
          sanitized_tokens.map do |token|
            if token.ends_with?('*')
              # prefix search
              token.sub!(/\*\z/, '')
              "(#{WEIGHTS.map{|w| "#{token}:*#{w}"}.join(" | ")})"
            else
              token
            end
          end.join @operator
        end
      end


      def self.for(query_string, scope)
        new(query_string, scope).query
      end

      def initialize(query_string, scope)
        @query_string = query_string
        @scope = scope
      end

      def query
        query_sql = QueryBuilder.new(@query_string, all_words: true).to_sql
        @scope.
          joins(", #{query_sql}").
          where("query @@ #{Decidim::User.table_name}.tsv")
      end

    end
  end
end
