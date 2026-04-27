# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::Resp::Gtstc do
  it 'parses real GL30MEU GTSTC response (backup-battery stops charging)' do
    # Captured from Linode TCP server on 2026-04-22 14:25:08 UTC during live unplug test.
    # Event state 0 = "Stop charge" (user unplugged), 1 = "Charge full".
    response = '970101,867963069921253,,0,4159,100,0260,0003,E2A4,01C0B30F,22,0,20260422142507,38E8'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response).not_to eq({})
    expect(parsed_response['protocol_version']).to eq 970_101
    expect(parsed_response['unique_id']).to eq 867_963_069_921_253
    expect(parsed_response['event_state']).to eq 0
    expect(parsed_response['battery_voltage']).to eq 4159
    expect(parsed_response['battery_percentage']).to eq 100
    expect(parsed_response['csq_rssi']).to eq 22
    expect(parsed_response['csq_ber']).to eq 0
    expect(parsed_response['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20260422142507') }.in_time_zone
  end

  it 'has 14 keys' do
    response = '970101,867963069921253,,0,4159,100,0260,0003,E2A4,01C0B30F,22,0,20260422142507,38E8'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response.keys.length).to eq 14
  end
end
