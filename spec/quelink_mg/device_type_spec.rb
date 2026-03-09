# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::DeviceType do
  describe '.detect' do
    it 'detects GL320M from C3 prefix' do
      expect(described_class.detect('C30204')).to eq :gl320m
    end

    it 'detects GL30MEU from 97 prefix' do
      expect(described_class.detect('970101')).to eq :gl30meu
    end

    it 'returns unknown for unrecognized prefix' do
      expect(described_class.detect('XX0101')).to eq :unknown
    end

    it 'detects GL320M from full GTFRI response' do
      response = 'C30204,860201061504521,,0,0,1,1,0.0,0,96.2,21.012847,52.200338,20230813061232,0260,0003,E31F,0447020D,,34,20230813061231,3E94'
      expect(described_class.detect(response.split(',').first)).to eq :gl320m
    end

    it 'detects GL30MEU from full GTFRI response' do
      response = '970101,861106059716756,GL30MEU,0,0,1,1,0.0,70,17.8,121.348554,31.163204,20231011084221,0460,0000,5B63,0867349C,21,0,3552,2,1,0,,20231011084241,1A0C'
      expect(described_class.detect(response.split(',').first)).to eq :gl30meu
    end
  end
end
