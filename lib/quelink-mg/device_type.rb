# frozen_string_literal: true

module QuelinkMg
  module DeviceType
    def self.detect(protocol_version)
      case protocol_version[0..1]
      when 'C3' then :gl320m
      when '97' then :gl30meu
      else :unknown
      end
    end
  end
end
