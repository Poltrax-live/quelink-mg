# quelink-mg

Management of commands sent or received from Queclink GPS tracker devices. Supports **GL320M** and **GL30MEU** (GL30MEUR01).

## Installation

The quelink-mg gem is available at rubygems.org. You can install with:

```
gem install quelink-mg
```

Alternatively, you can install the gem with bundler:

```ruby
# Gemfile
gem 'quelink-mg'
```

After doing bundle install, you should have the gem installed in your bundle.

## Configuration

```ruby
QuelinkMg.configure do |config|
	config.time_zone = ActiveSupport::TimeZone.new('Europe/Warsaw') # default
end
```

## Supported devices

| Feature | GL320M | GL30MEU |
|---------|--------|---------|
| Protocol prefix | `C3` | `97` |
| Default password | `gl320m` | `gl30` |
| Namespace | `QuelinkMg::At`, `QuelinkMg::Resp`, etc. | `QuelinkMg::Gl30meu::At`, `QuelinkMg::Gl30meu::Resp`, etc. |

## Usage

### Device type detection

Detect the device model from any raw message using the protocol version prefix:

```ruby
response = 'C30204,860201061504521,,0,0,1,...'
device_type = QuelinkMg::DeviceType.detect(response.split(',').first)
# => :gl320m

response = '970101,861106059716756,GL30MEU,0,0,1,...'
device_type = QuelinkMg::DeviceType.detect(response.split(',').first)
# => :gl30meu
```

### Building AT commands

AT commands are sent from the server to the device. Build them by passing a params hash:

```ruby
# GL320M — set report intervals (GTFRI)
command = QuelinkMg::At::Gtfri.new(params: {
	password: 'gl320m',
	mode: 2,
	check_interval: 30,
	send_interval: 60,
	serial_number: 'FFFF'
})
command.message
# => "AT+GTFRI=gl320m,,,,,,30,60,,,,,,,,,,,,FFFF$"

# GL320M — remote control / query firmware version (GTRTO)
command = QuelinkMg::At::Gtrto.new(params: {
	password: 'gl320m',
	sub_command: 8,
	serial_number: 'FFFF'
})
command.message
# => "AT+GTRTO=gl320m,8,,,,,,FFFF$"

# GL30MEU — configure device (GTCFG)
command = QuelinkMg::Gl30meu::At::Gtcfg.new(params: {
	password: 'gl30',
	continuous_send_interval: 30,
	gnss_enable: 1,
	led_on: 1,
	serial_number: 'FFFF'
})
command.message
# => "AT+GTCFG=gl30,,,,,,,30,,,,,,,,1,,,,,,,,,1,FFFF$"

# GL30MEU — set APN (GTBSI)
command = QuelinkMg::Gl30meu::At::Gtbsi.new(params: {
	password: 'gl30',
	lte_apn: 'iot.1nce.net',
	network_mode: 2,
	lte_mode: 2,
	serial_number: 'FFFF'
})
command.message
# => "AT+GTBSI=gl30,,iot.1nce.net,,,2,2,,,FFFF$"
```

Invalid parameters raise specific exceptions:

```ruby
QuelinkMg::At::Gtfri.new(params: {
	password: 'gl320m',
	mode: 99, # invalid — must be 0..5
	serial_number: 'FFFF'
}).message
# => raises InvalidATGTFRIException
```

### Parsing device responses (RESP)

Parse real-time messages sent from device to server. Values are automatically type-cast (integers, floats, timezone-aware timestamps):

```ruby
# GL320M — position report (GTFRI)
response = 'C30204,860201061504521,,0,0,1,1,0.0,0,96.2,21.012847,52.200338,20230813061232,0260,0003,E31F,0447020D,,34,20230813061231,3E94'
parsed = QuelinkMg::Resp::Gtfri.new(response:).hash
# => {
#   "protocol_version" => "C30204",
#   "unique_id" => 860201061504521,
#   "longitude" => 21.012847,
#   "latitude" => 52.200338,
#   "speed" => 0.0,
#   "battery_percentage" => 34,
#   "gps_utc_time" => 2023-08-13 08:12:32 +0200,
#   ...
# }

# GL30MEU — position report (GTFRI) — different fields
response = '970101,861106059716756,GL30MEU,0,0,1,1,0.0,70,17.8,121.348554,31.163204,20231011084221,0460,0000,5B63,0867349C,21,0,3552,2,1,0,,20231011084241,1A0C'
parsed = QuelinkMg::Gl30meu::Resp::Gtfri.new(response:).hash
# => {
#   "protocol_version" => 970101,
#   "unique_id" => 861106059716756,
#   "device_name" => "GL30MEU",
#   "longitude" => 121.348554,
#   "latitude" => 31.163204,
#   "csq_rssi" => 21,
#   "battery_voltage" => 3552,
#   "movement_status" => 1,
#   ...
# }

# GL30MEU — device info (GTINF)
response = '970101,867963069921253,,89882280666211671601,24,0,,1,,62,,20251220005654,,,,,,,,20260224104605,1182'
parsed = QuelinkMg::Gl30meu::Resp::Gtinf.new(response:).hash
# => {
#   "unique_id" => 867963069921253,
#   "iccid" => "89882280666211671601",
#   "csq_rssi" => 24,
#   "battery_percentage" => 62,
#   ...
# }
```

### Parsing command acknowledgments (ACK)

Parse ACK messages the device sends after receiving an AT command:

```ruby
# GL320M
response = 'D40102,868239051011356,,READ,0040,20210816045509,004F'
parsed = QuelinkMg::Ack::Gtrto.new(response:).hash
# => {
#   "protocol_version" => "D40102",
#   "unique_id" => 868239051011356,
#   "sub_command" => "READ",
#   "serial_number" => "0040",
#   ...
# }

# GL30MEU
response = '970101,861106059716756,GL30MEU,5,FFFF,20231011084300,0A01'
parsed = QuelinkMg::Gl30meu::Ack::Gtrto.new(response:).hash
# => {
#   "unique_id" => 861106059716756,
#   "device_name" => "GL30MEU",
#   "sub_command" => 5,
#   ...
# }
```

### Parsing buffered messages (BUFF)

Buffered messages were stored on the device while it was offline. Same interface as RESP:

```ruby
# GL320M
parsed = QuelinkMg::Buff::Gtfri.new(response:).hash

# GL30MEU
parsed = QuelinkMg::Gl30meu::Buff::Gtfri.new(response:).hash
```

## Available classes

### GL320M

| Type | Classes |
|------|---------|
| AT commands | `Gtbsi`, `Gtcfg`, `Gtcmd`, `Gtfri`, `Gtqss`, `Gtrto`, `Gtsri`, `Gtudf`, `Gtupd` |
| Response parsers | `Gtfri`, `Gtgsv`, `Gtinf`, `Gtsos`, `Gtstt`, `Gtupc`, `Gtupd`, `Gtver` |
| ACK parsers | `Gtbsi`, `Gtcfg`, `Gtcmd`, `Gtfri`, `Gtqss`, `Gtrto`, `Gtsri`, `Gtudf` |
| Buff parsers | `Gtfri` |

### GL30MEU

| Type | Classes |
|------|---------|
| AT commands | `Gtbsi`, `Gtcfg`, `Gtrto`, `Gtsri`, `Gtupd` |
| Response parsers | `Gtati`, `Gtfri`, `Gtinf`, `Gtupc`, `Gtupd` |
| ACK parsers | `Gtbsi`, `Gtcfg`, `Gtrto`, `Gtsri` |
| Buff parsers | `Gtfri` |

## Development

Building gem locally:

```
gem build *.gemspec -o pkg/quelink-mg.gem
```

Installing:

```
gem install pkg/quelink-mg.gem
```

Running tests:

```
bundle exec rspec
```

