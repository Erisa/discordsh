module YuukiBot
  require 'discordrb'
  require 'open-uri'
  require 'commandrb'

  require_relative 'modules/config'
  require_relative 'modules/version'

  init_hash = YuukiBot.build_init

  $cbot = CommandrbBot.new(init_hash)

  module_dirs = %w(owner)
  module_dirs.each {|dir|
    Dir["modules/#{dir}/*.rb"].each { |r|
     require_relative r
     puts "Loaded: #{r}" if @config['verbose']
    }
  }

  # Load Extra Commands if enabled.
  if YuukiBot.config['extra_commands']
    require 'json'
    # require 'flippy'
    puts 'Loading: Extra commands...' if @config['verbose']
    Dir['modules/extra/*.rb'].each { |r| require_relative r; puts "Loaded: #{r}" if @config['verbose'] }
  end
  puts '>> Initial loading succesful!! <<'
  exit(1001) if YuukiBot.config['pretend_run']
  $cbot.bot.run
end
