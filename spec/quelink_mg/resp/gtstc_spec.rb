# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Resp::Gtstc do
  it 'parses valid response' do
    response = 'C30203,015181001707687,gl320m,,1,0.0,0,238.3,114.016303,22.539099,20190911055554,0460,0001,253D,AEC3,0.1,20200811135555,0123$'

    parsed = described_class.new(response:).hash
    expect(parsed['protocol_version']).to eq 'C30203'
    expect(parsed['unique_id']).to eq 15_181_001_707_687.0
    expect(parsed['device_name']).to eq 'gl320m'
    expect(parsed['reserved']).to eq ''
    expect(parsed['gps_accuracy']).to eq 1
    expect(parsed['speed']).to eq 0.0
    expect(parsed['azimuth']).to eq 0
    expect(parsed['altitude']).to eq 238.3
    expect(parsed['last_longitude']).to eq 114.016303
    expect(parsed['last_latitude']).to eq 22.539099
    expect(parsed['gps_utc_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20190911055554') }.in_time_zone
    expect(parsed['mcc']).to eq 460
    expect(parsed['mnc']).to eq 1
    expect(parsed['lac']).to eq '253D'
    expect(parsed['cell_id']).to eq 'AEC3'
    expect(parsed['odo_mileage']).to eq 0.1
    expect(parsed['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20200811135555') }.in_time_zone
  end
end
