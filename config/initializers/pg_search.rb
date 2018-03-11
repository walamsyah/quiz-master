Rails.application.config.to_prepare do
  module PgSearch
    module Features
      class TSearch
        def self.valid_options
          super + [:dictionary, :prefix, :negation, :any_word, :normalization, :tsvector_column, :highlight, :exact_number, :strip_leading_zero]
        end

        private
        # Override pg_search behaviour to only partial match non-number terms.
        def tsquery_for_term(unsanitized_term) # rubocop:disable Metrics/AbcSize
          if options[:negation] && unsanitized_term.start_with?("!")
            unsanitized_term[0] = ''
            negated = true
          end

          sanitized_term = unsanitized_term.gsub(DISALLOWED_TSQUERY_CHARACTERS, " ")

          term_sql = Arel.sql(normalize(connection.quote(sanitized_term)))

          # After this, the SQL expression evaluates to a string containing the term surrounded by single-quotes.
          # If :prefix is true, then the term will have :* appended to the end.
          # If :negated is true, then the term will have ! prepended to the front.
          terms = [
            (Arel::Nodes.build_quoted('!') if negated),
            Arel::Nodes.build_quoted("' "),
            term_sql,
            Arel::Nodes.build_quoted(" '"),
            (Arel::Nodes.build_quoted(":*") if (options[:prefix]) && !(options[:exact_number] && (sanitized_term =~ /^\d+$/)))
          ].compact

          tsquery_sql = terms.inject do |memo, term|
            Arel::Nodes::InfixOperation.new("||", memo, Arel::Nodes.build_quoted(term))
          end

          Arel::Nodes::NamedFunction.new(
            "to_tsquery",
            [dictionary, tsquery_sql]
          ).to_sql
        end

        # NOTICE:
        # The pg_search gem transform terms with character ['\\?:] into a white space,
        # this is unexpected because there is no way we can create a search text with
        # an empty space, therefore terms with the above character need to use a
        # different representation in the search text tsvector column, in this case,
        # it has been decided to use dash (-).
        def tsquery
          return "''" if query.blank?

          # REFERENCE:
          # https://github.com/Casecommons/pg_search/blob/d77957e92c9420cfc3fcb2b215e0dfd9b8451077/lib/pg_search/features/tsearch.rb#L32
          sanitized_term = query.gsub(DISALLOWED_TSQUERY_CHARACTERS, "-")

          # REFERENCE:
          # https://github.com/Casecommons/pg_search/blob/d77957e92c9420cfc3fcb2b215e0dfd9b8451077/lib/pg_search/features/tsearch.rb#L57-L59
          query_terms = sanitized_term.split(/[^\w\-\.\_]/).reject { |word| (word.length < 3) && !(word =~ /^\d+$/) }.map { |a| options[:strip_leading_zero] ? a.gsub(/^0+(?=\d+$)/, '') : a }.compact
          return "''" if query_terms.blank?
          tsquery_terms = query_terms.map { |term| tsquery_for_term(term) }
          tsquery_terms.join(options[:any_word] ? ' || ' : ' && ')
        end
      end
    end

    class ScopeOptions
      def apply(scope)
        scope.
          select("#{quoted_table_name}.*").
          where(conditions).
          order("(#{rank}) DESC, #{order_within_rank}").
          extend(DisableEagerLoading)
      end
    end
  end
end
