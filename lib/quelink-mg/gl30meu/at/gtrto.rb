# frozen_string_literal: true

module QuelinkMg
  module Gl30meu
    module At
      class Gtrto < ::QuelinkMg::At::Base
        def message
          validate_values

          "AT+GTRTO=#{joined_params}$"
        end

        private

        GTRTO_VALID_PARAMS = %i[password sub_command single_command_configuration reserved
                                reserved reserved sub_command_parameter serial_number].freeze

        def joined_params
          GTRTO_VALID_PARAMS.map { |method| @params.fetch(method, nil) }.join(',')
        end

        def validate_values
          acceptable_values = {
            sub_command: (1..7).to_a + [0xB, 0xD, 0x1C, 0x31, 0x33, 0x34]
          }

          verify_params(acceptable_values, InvalidATGTRTOException)
        end
      end
    end
  end
end
