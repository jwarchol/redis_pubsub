# Redis PubSub with EM::Channel in Goliath

This example app uses Redis publish/subscribe channels to pass messages from an
input source (input.rb) to the API clients via Goliath and EM::Channel. The idea 
is to have just one connection to Redis, rather than one per connection as seen 
in other examples. Within the context of one instance of this Goliath app, messages
are further multiplexed to connected clients via Event Machine channels. 

The current input example pings a remote host and passes the resulting ping output
to the redis channel. 

NOTE: Be sure you don't use em-synchrony's hiredis driver in the config file. The
execution is on the root fiber there and em-synchrony will not like that. Using the
regular EM hiredis driver lets that work happen on the reactor loop without causing 
any problems. 

The only real trick here was doing some em-synchrony style fiber yielding and resuming
in order to have the request wait until there is a message on the channel. This API
is currently for a long-polling kind of interface. It could be extended for an HTTP 
stream. 
