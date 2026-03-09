# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module At
      class Gtcfg < ::QuelinkMg::At::Base
        def message
          validate_values

          "AT+GTCFG=#{joined_params}$"
        end

        private

        GTCFG_VALID_PARAMS = %i[password new_password device_name gnss_timeout event_mask report_item_mask
                                mode_selection continuous_send_interval reserved start_mode specified_time_of_day
                                reserved wakeup_interval reserved reserved reserved gnss_enable agps_mode
                                gsm_report reserved reserved battery_low_percentage function_button_mode
                                reserved sos_report_mode wifi_report led_on serial_number].freeze

        def joined_params
          GTCFG_VALID_PARAMS.map { |method| @params.fetch(method, nil) }.join(',')
        end

        def validate_values
          acceptable_values = {
            gnss_timeout: (5..300),
            mode_selection: (0..5),
            continuous_send_interval: (30..86_400),
            start_mode: (0..3),
            wakeup_interval: (60..86_400),
            gnss_enable: (0..1),
            agps_mode: (0..1),
            battery_low_percentage: (0..30),
            function_button_mode: (0..3),
            sos_report_mode: (0..2),
            wifi_report: (0..1),
            led_on: (0..2)
          }

          verify_params(acceptable_values, InvalidATGTCFGException)
        end
      end
    end
  end
end
