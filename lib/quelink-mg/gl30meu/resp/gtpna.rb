# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtpna < ::QuelinkMg::Resp::Base
        GTPNA_RESP_KEYS = %w[protocol_version unique_id device_name power_on_type send_time count_number].freeze

        def hash
          unify_keys(GTPNA_RESP_KEYS.zip(@response.split(',')).to_h)
        end
      end
    end
  end
end
