# frozen_string_literal: true

require 'spec_helper'

RSpec.describe QuelinkMg::At::Gtupd do
  it 'creates command when params are valid' do
    params =
      {
        password: 'gl310m',
        subcommand: 0,
        max_download_retry: 0,
        download_timeout: 10,
        download_protocol: 0,
        download_url: 'https://example.org',
        update_type: 0,
        serial_number: 'FFFF'
      }

    expect(described_class.new(params:).message).to eq 'AT+GTUPD=gl310m,0,0,10,0,,,https://example.org,,0,,,FFFF$'
  end

  it 'raises error on wrong params' do
    expect { described_class.new(params: { download_timeout: 666 }).message }.to raise_error(InvalidATGTUPDException)
  end
end
