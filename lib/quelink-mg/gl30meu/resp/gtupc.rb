# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module Resp
      class Gtupc < ::QuelinkMg::Resp::Base
        GTUPC_RESP_KEYS = %w[protocol_version unique_id device_name command_id result download_url send_time
                             count_number].freeze

        def hash
          unify_keys(GTUPC_RESP_KEYS.zip(@response.split(',')).to_h)
        end
      end
    end
  end
end
