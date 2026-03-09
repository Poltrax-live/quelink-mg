# frozen_string_literal: true

module QuelinkMg
  module Resp
    class Base
      QUELINK_DATE_FORMAT = '%Y%m%d%H%M%S'

      def initialize(response:)
        @response = response
      end

      private

      def float?(value)
        !Float(value, exception: false).nil?
      end

      def integer?(value)
        !Integer(value, exception: false).nil?
      end

      def date?(value)
        date = DateTime.strptime(value, QUELINK_DATE_FORMAT)

        !date.nil? && (date - DateTime.now).abs < 25 * 365
      rescue Date::Error
        false
      end

      def transform_with_timezone(value)
        Time.use_zone('UTC') { Time.zone.parse(value) }.in_time_zone
      end

      def unify_keys(hash, skip_number_change = false)
        hash.transform_values do |v|
          if date?(v)
            transform_with_timezone(v)
          elsif integer?(v) && !skip_number_change
            v.to_i
          elsif float?(v) && !skip_number_change
            v.to_f
          else
            v
          end
        end
      end
    end
  end
end
