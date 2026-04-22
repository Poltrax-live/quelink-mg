# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtstc < ::QuelinkMg::Resp::Base
        GTSTC_RESP_KEYS = %w[protocol_version unique_id device_name event_state battery_voltage battery_percentage
                             mcc mnc lac cell_id csq_rssi csq_ber send_time count_number].freeze

        def hash
          unify_keys(GTSTC_RESP_KEYS.zip(@response.split(',')).to_h)
        end
      end
    end
  end
end
