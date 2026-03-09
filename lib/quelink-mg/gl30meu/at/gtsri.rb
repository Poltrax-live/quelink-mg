# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module At
      class Gtsri < ::QuelinkMg::At::Base
        def message
          validate_values

          "AT+GTSRI=#{joined_params}$"
        end

        private

        GTSRI_VALID_PARAMS = %i[password report_mode reserved buffer_mode main_server_ip main_server_port
                                backup_server_ip backup_server_port sms_gateway heartbit_interval sack_enable
                                sms_ack_enable reserved reserved reserved serial_number].freeze

        def joined_params
          GTSRI_VALID_PARAMS.map { |method| @params.fetch(method, nil) }.join(',')
        end

        def validate_values
          acceptable_values = {
            report_mode: (0..7),
            buffer_mode: (0..2),
            main_server_port: (0..65_535),
            backup_server_port: (0..65_535),
            heartbit_interval: [0] + (5..360).to_a,
            sack_enable: (0..2),
            sms_ack_enable: (0..1)
          }

          verify_params(acceptable_values, InvalidATGTSRIException)
        end
      end
    end
  end
end
