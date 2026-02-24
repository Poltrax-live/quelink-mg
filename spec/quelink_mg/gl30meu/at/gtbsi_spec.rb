# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::At::Gtbsi do
  it 'creates command with eDRX params' do
    params = {
      password: 'gl30',
      lte_apn: 'iot.1nce.net',
      network_mode: 2,
      lte_mode: 2,
      apn_authentication_methods: 0,
      edrx_periodic: '0101',
      edrx_m1_pagings: '0101',
      edrx_nb2_pagings: '0010',
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTBSI=gl30,iot.1nce.net,,,,,,2,2,0,0101,0101,0010,,,,FFFF$'
  end

  it 'creates basic network command' do
    params = {
      password: 'gl30',
      lte_apn: 'iot.1nce.net',
      network_mode: 2,
      lte_mode: 2,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTBSI=gl30,iot.1nce.net,,,,,,2,2,,,,,,,,FFFF$'
  end

  it 'raises error on missing params' do
    expect { described_class.new(params: {}).message }.to raise_error(InvalidATGTBSIException)
  end

  it 'raises error on invalid network_mode' do
    params = {
      password: 'gl30',
      network_mode: 5,
      serial_number: 'FFFF'
    }

    expect { described_class.new(params:).message }.to raise_error(InvalidATGTBSIException)
  end
end
