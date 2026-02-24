# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtati < ::QuelinkMg::Resp::Base
        GTATI_RESP_KEYS = %w[protocol_version unique_id device_name device_type ati_mask
                             firmware_version ble_firmware_version modem_firmware_version
                             wifi_firmware_version hardware_version modem_hardware_version
                             sensor_id send_time count_number].freeze

        def hash
          unify_keys(GTATI_RESP_KEYS.zip(@response.split(',')).to_h, true)
        end
      end
    end
  end
end
