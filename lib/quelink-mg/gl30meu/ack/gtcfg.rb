# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Ack
      class Gtcfg < ::QuelinkMg::Ack::Base
        GTCFG_ACK_KEYS = %w[protocol_version unique_id device_name serial_number send_time count_number].freeze

        def hash
          unify_keys(GTCFG_ACK_KEYS.zip(@response.split(',')).to_h)
        end
      end
    end
  end
end
