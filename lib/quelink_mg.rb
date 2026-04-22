# frozen_string_literal: true

require 'pry'
require 'date'
require 'active_support'
require 'active_support/time_with_zone'
require 'active_support/core_ext/time/zones'

require File.expand_path('quelink-mg/at/base.rb', __dir__)
require File.expand_path('quelink-mg/at/gtbsi.rb', __dir__)
require File.expand_path('quelink-mg/at/gtcfg.rb', __dir__)
require File.expand_path('quelink-mg/at/gtcmd.rb', __dir__)
require File.expand_path('quelink-mg/at/gtfri.rb', __dir__)
require File.expand_path('quelink-mg/at/gtqss.rb', __dir__)
require File.expand_path('quelink-mg/at/gtrto.rb', __dir__)
require File.expand_path('quelink-mg/at/gtsri.rb', __dir__)
require File.expand_path('quelink-mg/at/gtudf.rb', __dir__)
require File.expand_path('quelink-mg/at/gtupd.rb', __dir__)

require File.expand_path('quelink-mg/resp/base.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtfri.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtgsv.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtinf.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtsos.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtstt.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtupc.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtver.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtupd.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtbtc.rb', __dir__)
require File.expand_path('quelink-mg/resp/gtstc.rb', __dir__)

require File.expand_path('quelink-mg/ack/base.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtbsi.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtcfg.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtcmd.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtfri.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtqss.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtrto.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtsri.rb', __dir__)
require File.expand_path('quelink-mg/ack/gtudf.rb', __dir__)

require File.expand_path('quelink-mg/buff/base.rb', __dir__)
require File.expand_path('quelink-mg/buff/gtfri.rb', __dir__)

require File.expand_path('quelink-mg/device_type.rb', __dir__)

require File.expand_path('quelink-mg/gl30meu/at/gtrto.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/at/gtcfg.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/at/gtbsi.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/at/gtsri.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/at/gtupd.rb', __dir__)

require File.expand_path('quelink-mg/gl30meu/resp/gtfri.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtati.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtinf.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtupc.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtupd.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtbtc.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtstc.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/resp/gtpna.rb', __dir__)

require File.expand_path('quelink-mg/gl30meu/ack/gtrto.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/ack/gtcfg.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/ack/gtbsi.rb', __dir__)
require File.expand_path('quelink-mg/gl30meu/ack/gtsri.rb', __dir__)

require File.expand_path('quelink-mg/gl30meu/buff/gtfri.rb', __dir__)

require File.expand_path('quelink-mg/configuration.rb', __dir__)

module QuelinkMg
  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
