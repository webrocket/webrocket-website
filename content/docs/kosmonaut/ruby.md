---
title: Kosmonaut for Ruby
kind:  article
group: docs
---

### Status

Kosmonaut version for Ruby is an **official** client. It is considered to be **stable**. 

Ruby implementation follows [the concept of Kosmonaut](/docs/kosmonaut/) by providing
two kind of sockets. Below you can find a trivial examples of usage both
of them.


### Installation

You can install it easily via rubygems:

    $ gem install kosmonaut
    
If you are using bundler, then just add the following line:

    gem "kosmonaut", ">= 0.4.0"

### Client

Client will be used to manage channels, provide authentication gateway and broadcast
events from the application.

Here's trivial example:

    #!ruby
    c = Kosmonaut::Client.new("wr://token@127.0.0.1:8081/vhost")
    c.open_channel("world")
    c.broadcast("world", "hello", {:who => "Chris"})
    c.broadcast("world", "bye", {:see_you_when => "Soon!"})
    
Requesting single access token operation:

    token = c.request_single_access_token(".*")
    
### Worker

Worker is designed to listen and handle all messages incoming from the backend
endpoint of WebRocket server. Ruby version of kosmonaut provides some high level
interface to deal with the handlers.

Here's an example of backend for the chat application:

    #!ruby
    class ChatBackend
      # This method will be triggered on 'chat/save_to_history' event.
      def save_to_history(msg)
        room.find(msg[:room])
        room.history.append(msg)
      end
    end

It can be used now within the worker as following:

    #!ruby
    Kosmonaut::Application.build "wr://token@127.0.0.1:8081/vhost" do
      use ChatBackend, :as => "chat"
      run
    end

### Worker in separate thread

Kosmonaut is threadsafe, so worker application can be run safely in separate
thread:

    #!ruby
    app = Kosmonaut::Application.build("wr://token@127.0.0.1:8081/vhost") { ... }
    Thread.new { app.run }
    
In this case you can stop the listener whenever you want from other thread using
`stop` method:

    #!ruby
    app.stop

### Troubleshooting

If you encountered any problem while using Kosmonaut for Ruby, please let us not about it
by creating an [issue on github](http://github.com/webrocket/kosmonaut-ruby/issues).
