# discordsh
Simple bot that runs Shell commands inside [Discord](https://discordapp.com). Based off Yuuki-Bot.

# Self-Hosting:

## Requirements
- Ruby 2.3.1+ (Due to a bug in the Ruby interpreter, this bot won't work correctly with lower versions.)
- bundler (`gem install bundler`)

## Install
1. Clone the repo: `git clone https://github.com/Seriell/discordsh.git`
2. cd into the repo: `cd discordsh`
3. Create a bot account and edit the config files accordingly (See config/README.md)
4. Install bundler if you haven't already: `gem install bundler`
5. Install the bundle: `bundle install`
6. Run the bot. For Linux: `sh run_linux.sh`. For Windows: `run_windows.bat`.

## Updating
1. Pull any changes from the repo: `git pull`
2. Check any config changes. Open `config/config.yml.example` and see if any new information is needed in your `config/config.yml.example`
3. Update the bundle: `bundle update`
4. Run the bot: `sh run_linux.sh` or `run_windows.bat`

Please report any issues to `@Seriel#3760` | `<@228574821590499329>` on Discord, or open an Issue on Github! <br />
You can also join our server for support! https://discord.gg/kZ9dHxJ <br />

Enjoy~
<br />

# Credits
- [meew0](https://github.com/meew0/) for [Discordrb](https://github.com/meew0/discordrb)
