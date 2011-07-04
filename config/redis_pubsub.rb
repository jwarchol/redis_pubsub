require 'em-hiredis' # NOT em-synchrony/hiredis, this happens in the reactor, not a request fiber

config['channel'] = EM::Channel.new


config['redis'] ||= EM::Hiredis.connect

config['redis'].subscribe('ping')
config['redis'].on(:message)  do |ch, msg|
  config['channel'].push(msg)
end
