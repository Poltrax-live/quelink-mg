# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::Resp::Gtinf do
  it 'parses real GL30MEU GTINF response (21 fields)' do
    response = '970101,867963069921253,,89882280666211671601,24,0,,1,,62,,20251220005654,,,,,,,,20260224104605,1182'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response).not_to eq({})
    expect(parsed_response['protocol_version']).to eq 970_101
    expect(parsed_response['unique_id']).to eq 867_963_069_921_253
    expect(parsed_response['device_name']).to eq ''
    expect(parsed_response['iccid']).to eq 89_882_280_666_211_671_601
    expect(parsed_response['csq_rssi']).to eq 24
    expect(parsed_response['csq_ber']).to eq 0
    expect(parsed_response['mode_selection']).to eq 1
    expect(parsed_response['battery_percentage']).to eq 62
    expect(parsed_response['last_gnss_fix_utc_time']).to eq Time.use_zone('UTC') {
      Time.zone.parse('20251220005654')
    }.in_time_zone
    expect(parsed_response['movement_status']).to eq ''
    expect(parsed_response['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20260224104605') }.in_time_zone
    expect(parsed_response['count_number']).to eq 1182
  end

  it 'has 13 unique keys (reserved fields collapse)' do
    response = '970101,867963069921253,,89882280666211671601,24,0,,1,,62,,20251220005654,,,,,,,,20260224104605,1182'

    parsed_response = described_class.new(response:).hash
    expect(parsed_response.keys.length).to eq 13
  end
end
