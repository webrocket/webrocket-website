---
title: Kosmonaut for Ruby
kind:  article
---

Kosmonaut version for Ruby is an **official** client. It is considered to be **stable**. 

Ruby implementation follows [the concept of Kosmonaut](/docs/kosmonaut/) by providing
two kind of sockets. Below you can find a trivial examples of usage both
of them.


### Installation

You can install it easily via rubygems:

    $ gem install kosmonaut
    
If you are using bundler, then just add the following line:

    gem "kosmonaut", ">= 0.3.0"

### Client

Client will be used to manage channels, provide authentication gateway and broadcast
events from the application.

Initialization:

    #!ruby
    client = Kosmonaut::Client.new("wr://token...@127.0.0.1:8080/vhost")

Opening channel:

    #!ruby
    client.open_channel("room")
    client.open_channel("presence-room")
    client.open_channel("private-room")
    
Closing channel:

    #!ruby
    client.close_channel("room")
    
Broadcasting data:

    #!ruby
    client.broadcast("room", "hello", {"what": "world"})

Requesting for a single access token:

    #!ruby
    client.request_single_access_token("joe", ".*")

### Worker

Worker is designed to listen and handle all messages incoming from the backend
endpoint of WebRocket server.

It shall be used by creating custom worker which inherits from `Kosmonaut::Worker`
and defines three handlers: `on_message`, `on_error` and `on_exception`. Here's an example:

    #!ruby
    class MyWorker < Kosmonaut::Worker
      def on_message(event, data)
        if event == "append_chat_history"
          @room = Room.find(data[:room_id])
          @room.messages.build(data[:message])
          @room.save!
        end
      end
   
      def on_error(err)
        puts "WEBROCKET ERROR: #{err.to_s}"
      end
  
      def on_exception(err)
        puts "INTERNAL ERROR: #{err.to_s}"
      end
    end

#### Handlers

**on_message** hanldles all valid incoming messages. It gets two arguments, first is an 
event name, second - data hash associated to this event. Errors raised from within this 
method are caught and handled by `on_exception` handler.

**on_error** handles WebRocket protocol errors. If something will go wrong
with the communication between worker and WebRocket's backend, then appropriate
error object will be passed to this method. The same as with `on_message`, all 
exceptions raised from within this method are caught and handled by `on_exception` 
handler.

**on_exception** handles internal errors. All exceptions raised from within
other handlers are caught and passed to this method.

#### Starting listener

To make your worker running, you have to use `listen` method:

    #!ruby
    worker = MyWorker.new("wr://token...@127.0.0.1:8080/vhost")
    worker.listen

Calling `listen` will block current thread. Worker automatically handles reconnects
and recovery from the errors. The only two cases when worker can break are when
specified token is invalid and `UnauthorizedError` appears, or when `on_exception`
callback raises an error. 

#### Listener in separate thread

Kosmonaut is threadsafe, so worker can be run safely in separate thread:

    #!ruby
    Thread.new { worker.listen }
    
In this case you can stop the listener whenever you want from other thread using
`stop` method:

    #!ruby
    worker.stop

### Troubleshooting

If you encountered any problem while using Kosmonaut for Ruby, please let us not about it
by creating an [issue on github](http://github.com/webrocket/kosmonaut-ruby/issues).
