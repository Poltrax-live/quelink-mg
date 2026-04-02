# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtfri < ::QuelinkMg::Resp::Base
        GTFRI_RESP_KEYS = %w[protocol_version unique_id device_name report_id report_type number
                             gps_accuracy speed azimuth elevation longitude latitude gps_utc_time
                             mcc mnc lac cell_id csq_rssi csq_ber battery_voltage current_mode_status
                             movement_status reserved reserved send_time count_number].freeze

        def hash
          result = unify_keys(GTFRI_RESP_KEYS.zip(@response.split(',')).to_h)
          result['battery_percentage'] = result['current_mode_status']
          result
        end
      end
    end
  end
end
