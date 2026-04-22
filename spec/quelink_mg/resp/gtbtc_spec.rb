# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Resp::Gtbtc do
  it 'parses valid response' do
    response = 'C30203,015181001707687,gl320m,1,0.0,0,210.5,114.016051,22.539205,20190911055726,0460,0001,253D,AEC3,0.1,20200811135727,012C$'

    parsed = described_class.new(response:).hash
    expect(parsed['protocol_version']).to eq 'C30203'
    expect(parsed['unique_id']).to eq 15_181_001_707_687.0
    expect(parsed['device_name']).to eq 'gl320m'
    expect(parsed['gps_accuracy']).to eq 1
    expect(parsed['speed']).to eq 0.0
    expect(parsed['azimuth']).to eq 0
    expect(parsed['altitude']).to eq 210.5
    expect(parsed['last_longitude']).to eq 114.016051
    expect(parsed['last_latitude']).to eq 22.539205
    expect(parsed['gps_utc_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20190911055726') }.in_time_zone
    expect(parsed['mcc']).to eq 460
    expect(parsed['mnc']).to eq 1
    expect(parsed['lac']).to eq '253D'
    expect(parsed['cell_id']).to eq 'AEC3'
    expect(parsed['odo_mileage']).to eq 0.1
    expect(parsed['send_time']).to eq Time.use_zone('UTC') { Time.zone.parse('20200811135727') }.in_time_zone
  end
end
