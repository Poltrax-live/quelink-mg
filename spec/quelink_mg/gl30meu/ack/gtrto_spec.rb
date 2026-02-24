# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::Ack::Gtrto do
  it 'parses valid GL30MEU GTRTO ACK' do
    response = '970101,861106059716756,GL30MEU,5,FFFF,20231011084300,0A01'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response['protocol_version']).to eq 970_101
    expect(parsed_response['unique_id']).to eq 861_106_059_716_756
    expect(parsed_response['device_name']).to eq 'GL30MEU'
    expect(parsed_response['sub_command']).to eq 5
    expect(parsed_response['serial_number']).to eq 'FFFF'
    expect(parsed_response['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20231011084300') }.in_time_zone
  end
end
