# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::At::Gtcfg do
  it 'creates command with continuous_send_interval' do
    params = {
      password: 'gl30',
      continuous_send_interval: 30,
      led_on: 1,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTCFG=gl30,,,,,,,30,,,,,,,,,,,,,,,,,,,1,FFFF$'
  end

  it 'creates full configuration command' do
    params = {
      password: 'gl30',
      new_password: 'gl30',
      device_name: 'GL30MEU',
      gnss_timeout: 60,
      event_mask: '0FFF',
      report_item_mask: '001F',
      mode_selection: 1,
      continuous_send_interval: 30,
      start_mode: 0,
      wakeup_interval: 300,
      gnss_enable: 1,
      agps_mode: 1,
      gsm_report: '0000',
      battery_low_percentage: 10,
      function_button_mode: 0,
      sos_report_mode: 0,
      wifi_report: 0,
      led_on: 1,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTCFG=gl30,gl30,GL30MEU,60,0FFF,001F,1,30,,0,,,300,,,,1,1,0000,,,10,0,,0,0,1,FFFF$'
  end

  it 'creates minimal command' do
    params = {
      password: 'gl30',
      gnss_enable: 1,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTCFG=gl30,,,,,,,,,,,,,,,,1,,,,,,,,,,,FFFF$'
  end

  it 'raises error on missing params' do
    expect { described_class.new(params: {}).message }.to raise_error(InvalidATGTCFGException)
  end

  it 'raises error on invalid led_on' do
    params = {
      password: 'gl30',
      led_on: 3,
      serial_number: 'FFFF'
    }

    expect { described_class.new(params:).message }.to raise_error(InvalidATGTCFGException)
  end

  it 'raises error on continuous_send_interval below minimum' do
    params = {
      password: 'gl30',
      continuous_send_interval: 5,
      serial_number: 'FFFF'
    }

    expect { described_class.new(params:).message }.to raise_error(InvalidATGTCFGException)
  end
end
