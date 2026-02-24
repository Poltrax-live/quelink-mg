# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtinf < ::QuelinkMg::Resp::Base
        GTINF_RESP_KEYS = %w[protocol_version unique_id device_name iccid csq_rssi csq_ber
                             reserved mode_selection reserved battery_percentage reserved
                             last_gnss_fix_utc_time movement_status
                             reserved reserved reserved reserved reserved reserved
                             send_time count_number].freeze

        def hash
          unify_keys(GTINF_RESP_KEYS.zip(@response.split(',')).to_h)
        end
      end
    end
  end
end
