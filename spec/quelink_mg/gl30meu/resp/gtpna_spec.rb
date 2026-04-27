# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::Resp::Gtpna do
  it 'parses real GL30MEU GTPNA response (power on)' do
    # Captured from Linode TCP server on 2026-04-22 14:19:49 UTC during power-on.
    # Power On Type 4 = "Manual power on for the first time".
    # Types 22/25/26 indicate charging transitions (USB connection / stop / full).
    response = '970101,867963069921253,,4,20260422141710,38E0'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response).not_to eq({})
    expect(parsed_response['protocol_version']).to eq 970_101
    expect(parsed_response['unique_id']).to eq 867_963_069_921_253
    expect(parsed_response['power_on_type']).to eq 4
    expect(parsed_response['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20260422141710') }.in_time_zone
  end

  it 'has 6 keys' do
    response = '970101,867963069921253,,4,20260422141710,38E0'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response.keys.length).to eq 6
  end
end
