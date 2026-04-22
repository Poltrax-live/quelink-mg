# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::Buff::Gtfri do
  it 'parses valid GL30MEU buffered GTFRI response' do
    response = '970101,861106059716756,GL30MEU,0,0,1,1,0.0,70,17.8,121.348554,31.163204,20231011084221,0460,0000,5B63,0867349C,21,0,3552,2,1,0,,20231011084241,1A0C'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response).not_to eq({})
    expect(parsed_response['longitude']).to eq 121.348554
    expect(parsed_response['latitude']).to eq 31.163204
    expect(parsed_response['battery_voltage']).to eq 3552
    expect(parsed_response['battery_percentage']).to eq 2
    expect(parsed_response['csq_rssi']).to eq 21
    expect(parsed_response['current_mode_status']).to eq 1
    expect(parsed_response['movement_status']).to eq 0
  end
end
