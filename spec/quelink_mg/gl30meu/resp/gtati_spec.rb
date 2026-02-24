# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::Resp::Gtati do
  it 'parses valid GL30MEU GTATI response' do
    response = '970101,861106059717499,GL30MEU,88,00043483,0118,0111,0227,0102,0101,0103,33,20231011002150,0AB7'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response).not_to eq({})
    expect(parsed_response['protocol_version']).to eq '970101'
    expect(parsed_response['unique_id']).to eq '861106059717499'
    expect(parsed_response['device_name']).to eq 'GL30MEU'
    expect(parsed_response['device_type']).to eq '88'
    expect(parsed_response['ati_mask']).to eq '00043483'
    expect(parsed_response['firmware_version']).to eq '0118'
    expect(parsed_response['ble_firmware_version']).to eq '0111'
    expect(parsed_response['modem_firmware_version']).to eq '0227'
    expect(parsed_response['wifi_firmware_version']).to eq '0102'
    expect(parsed_response['hardware_version']).to eq '0101'
    expect(parsed_response['modem_hardware_version']).to eq '0103'
    expect(parsed_response['sensor_id']).to eq '33'
    expect(parsed_response['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20231011002150') }.in_time_zone
    expect(parsed_response['count_number']).to eq '0AB7'
  end

  it 'keeps version fields as strings (skip_number_change)' do
    response = '970101,861106059717499,GL30MEU,88,00043483,0118,0111,0227,0102,0101,0103,33,20231011002150,0AB7'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response['firmware_version']).to be_a(String)
    expect(parsed_response['hardware_version']).to be_a(String)
    expect(parsed_response['ble_firmware_version']).to be_a(String)
    expect(parsed_response['modem_firmware_version']).to be_a(String)
  end
end
