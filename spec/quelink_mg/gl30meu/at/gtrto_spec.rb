# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::Gl30meu::At::Gtrto do
  it 'creates power off command' do
    params = {
      password: 'gl30',
      sub_command: 5,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTRTO=gl30,5,,,,,,FFFF$'
  end

  it 'creates reboot command' do
    params = {
      password: 'gl30',
      sub_command: 3,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTRTO=gl30,3,,,,,,FFFF$'
  end

  it 'creates device info request (0x33)' do
    params = {
      password: 'gl30',
      sub_command: 0x33,
      serial_number: 'FFFF'
    }

    expect(described_class.new(params:).message).to eq 'AT+GTRTO=gl30,51,,,,,,FFFF$'
  end

  it 'raises error on missing params' do
    expect { described_class.new(params: {}).message }.to raise_error(InvalidATGTRTOException)
  end

  it 'raises error on GL320M-only sub_command 0' do
    params = {
      password: 'gl30',
      sub_command: 0,
      serial_number: 'FFFF'
    }

    expect { described_class.new(params:).message }.to raise_error(InvalidATGTRTOException)
  end

  it 'raises error on invalid sub_command 0xFF' do
    params = {
      password: 'gl30',
      sub_command: 0xFF,
      serial_number: 'FFFF'
    }

    expect { described_class.new(params:).message }.to raise_error(InvalidATGTRTOException)
  end
end
