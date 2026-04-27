# frozen_string_literal: true

module QuelinkMg
  module At
    class Gtupd < Base
      def message
        validate_values

        "AT+GTUPD=#{joined_params}$"
      end

      private

      GTUPD_VALID_PARAMS = %i[password subcommand max_download_retry download_timeout download_protocol
                              download_username download_password
                              download_url reserved update_type reserved reserved serial_number].freeze

      def joined_params
        GTUPD_VALID_PARAMS.map { |method| @params.fetch(method, nil) }.join(',')
      end

      def validate_values
        acceptable_values = {
          download_retry: (0..3),
          download_timeout: (10..30)
        }

        verify_params(acceptable_values, InvalidATGTUPDException)
      end
    end
  end
end
