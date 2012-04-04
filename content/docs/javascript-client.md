---
title: JavaScript Client
kind:  article
group: docs
---

To eliminate compatibility problems and apply bugfixes easily the JavaScript 
client is bundled into and distributed together with the server. You don't
have to include extra JavaScript files to your project and care about updates.

### Setup

To include JavaScript client in your project you have to add the following
tag before any call of WebRocket functions:

    #!html
    <script type="text/javascript" src="http://hostname.com:8080/webrocket.js"></script>
    
WebRocket's JavaScript client is served on the same port and host as 
WebSockets endpoint. **Remember to change `hostname.com` and port (`8080`)
to correct values reffering to your configuration.

### Getting started

To initialize WebRocket instance use the following statement:

    #!javascript
    var wr = WebRocket('/vhost', {}, function(wr) {
       // Code executed after connection is established...
    });
    
You don't have to specify host and port here - if those are not specified
then server's hostname and port on which WebSockets endpoint is listening
will be used. 

Second parameter contains special [configuration parameters](#Extra+configuration).

### Channels and subscriptions

WebRocket provides channel based communication. To subscribe a channel
**it must exist**. Due the security reasons you have to create channel
first using `webrocket-admin` command or [Kosmonaut](/docs/kosmonaut/) 
Client. To subsribe a channel use the following statement:

    #!javascript
    var wr = new WebRocket('/vhost', {}, function(wr) {
        var helloChannel = wr.subscribe('hello', function(helloChannel) {
            // Code executed after subscription is confirmed.
        });
    });

If you subscribing to presence channel, then extra data parameter can
be specified:

    #!javascript
    var helloChannel = wr.subscribe('presence-hello', {
        name: 'Chris',
        age:  23,
    });

This additional data will be passed together with system subscription
events to all the subscribers, every time when someone will join the 
channel.

To unsubscribe channel use the following:

    #!javascript
    helloChannel.unsubscribe();
    
Or directly from WebRocket instance:

    #!javascript
    wr.unsubscribe('hello');

Similar to subscription, `unsubscribe` can take second argument with
extra data - it will be attached to system unsubsciption events sent
to all the subscribers.

### Authentication

If you want to broadcast on presence/private channels, or trigger background
operation then you have to authenticate first. To do this your backend
application needs to define an authentication operation, here's an example
in Sinatra framework (Ruby):

    #!ruby
    get '/webrocket/auth.json' do
      chan, uid = params[:channel], current_user.id 
      token = $kosmonaut.request_single_access_token(chan, uid)
      
      content_type 'application/json'
      { :token => token }.to_json
    end

To be more clear - authentication must request for a single access token
for specific channel (or group of channels) and explicit user ID (`uid`).
User identifier can be his unique ID, name, or whatever you want - the
only constraint is that it have to be unique.

Now, you are able to authenticate JavaScript session like following:

    #!javascript
    var wr = new WebRocket('/vhost', {}, funciton() {
        this.authenticate({channel: 'hello'});
    });
    
Notice, extra data specified in `authenticate` will be passed as GET
parameters to the request. The `authenticate` will automatically connect 
to `/webrocket/auth.js` and do all the job under the hood.

### System events

All the system events are prefixed with colon (eg. `:subscribed`).
Any of them can be handled using `bind` function on WebRocket instance
or on the channel:

    #!javascript
    helloChannel.bind(:)
