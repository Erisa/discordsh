module YuukiBot

  class << self
     attr_accessor :config
  end

  require 'yaml'
  # Load Config from YAML
  @config = YAML.load_file('config/config.yml')
  @config.each do |key, value|
    if value.nil?
      puts "config.yml: #{key} is nil!"
      puts 'Corrupt or incorrect Yaml.'
      exit
    else
      puts("config.yml: Found #{key}: #{value}") if @config['verbose']
    end
  end

  # owners.yml always overrides config.yml, but if it doesn't exist, config.yml will be honoured.
  # This ensures compatibility with old config files, meaning no owners file needs to be setup.
  if File.exists?('config/owners.yml')
    @config['owners'] = YAML.load_file('config/config.yml')['owners']
  end

  @config['debug'] = false if @config['debug'].nil?

  @new_events = {}

  if @config['token'].nil?
    puts 'No valid token entered!'
    exit
  end

  def self.build_init
    # Transfer it into an init hash.
    init_hash = {
      token: @config['token'],
      prefixes: @config['prefixes'],
      client_id: @config['client_id'],
      parse_self: @config['parse_self'],
      parse_bots: @config['parse_bots'],
      selfbot: @config['selfbot'],
      type: @config['type'],
      game: '',
      owners: @config['owners'],

      typing_default: @config['typing_default'],
      ready: proc {|event|
        case @config['status']
          when 'idle' || 'away' || 'afk' then event.bot.idle
          when 'dnd' then event.bot.dnd
          when 'online' then event.bot.online
          when 'invisible' || 'offline' then event.bot.invisible
          when 'stream' || 'streaming' then event.bot.stream(@config['game'], @config['twitch_url'])
          else
            raise 'No valid status found.'
        end
        event.bot.game = "on #{`hostname`}" rescue nil
        puts "[READY] Logged in as #{event.bot.profile.distinct} !"
        puts "[READY] Connected to #{event.bot.servers.count} servers!"
        if event.bot.servers.count == 0
          puts '[READY] You are not connected to any servers. Use the following URL to add your first one!'
          puts "[READY] Invite URL: #{event.bot.invite_url}"
        end
      },
      on_message: proc {|event|
        begin
          next if Config.ignored_servers.include?(event.server.id) || !Config.logging
        rescue
          nil
        end
        Logging.get_message(event, nil)
       }
    }
    return init_hash
  end
end
