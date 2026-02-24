# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtupd < ::QuelinkMg::Resp::Base
        GTUPD_RESP_KEYS = %w[protocol_version unique_id device_name code reserved send_time count_number].freeze

        def hash
          unify_keys(GTUPD_RESP_KEYS.zip(@response.split(',')).to_h)
        end
      end
    end
  end
end
