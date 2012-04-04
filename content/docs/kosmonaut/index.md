---
title: The concept of Kosmonaut
kind:  article
group: docs
---

WebRocket is a broker server, providing bidirectional connection support.
To enable such a support in easy and reliable way we designed the concept
of a client library - Kosmonaut.

### How it works?

Kosmonaut is divided into two different kinds of sockets. The **Client (REQ)**
is responsible for access control, channels management and broadcasting
data to the WebSockets. The **Worker (SUB)** is responsible for listening
to new messages incoming from the server. 

<blockquote>
Why those sockets are separated?
</blockquote>
Simply, because they do different things. You may want to use Client socket 
in services or controllers of your Web applications only for broadcasting 
when you don't need bidirectional features of WebRocket, etc. This layout 
allows for more flexibility and is very efficient in usage.

### The Client (REQ)

Client is a request-response type socket. It requests operation to be done
on the WebRocket server and waits for the response. There are 4 types of
operations supported by the client:

* **Opening new channel** - Client can request to open new channel on the
  fly. Channel types are distinguished by its name (`channeltype-name`, eg.
  `presence-foo`). Allowed channel types are `private` and `presence` - all
  other names will be treated as normal channels.
* **Closing existing channel** - All channels within the vhost can be
  deleted on the fly as well.
* **Broadcasting message on the channel** - Client can send message to 
  the existing channel. Messages sent to not-existing channels will be
  ignored.
* **Requesting for single access token** - Single access token is a security
  mechanism to protect frontend connection against hijacking or corruption.
  Frontend connection must issue a single access token to get authenticated.

<blockquote>
  Why channel must exist to broadcast on it? Isn't enough to create it
  automatically when needed?
</blockquote>  

This decision has been made due to security reasons. That mechanism protects 
the server from being flooded by unauthorized client automatically opening 
high number of channels. Though channels are cheap in WebRocket, high number 
of them opened at the time may cause denial of service problem.

### The Worker (SUB)

Worker is a subscribe type socket. It subscribes to the vhost's stream
and waits for the messages. Each new message coming from the server is
parsed and processed in appropriate way, defined by the user in his own
custom handlers.

<blockquote>
  What's the benefit of having worker instance running instead of implementing
  own WebSockets server?
</blockquote>

WebSockets server is very expensive in load, memory footprint and other
resources usage. Besides it forces maintainer to keep up with specification
changes and security updates. The concept of Kosmonaut's workers allows
you to use bidirectional connections and all the features of WebSockets
without worrying about all this problems. Kosmonaut protocol is very easy
to implement and cheap in execution - all the dirty work is done here
by WebRocket server. WebRocket is written to be fast and reliable and
optimized for high load by horizontal scalling.

### Protocol specification

Both, Worker and Client sockets use the same, simple text protocol to
communicate with the server. Detailed protocol specification can be
found in [this RFC document](http://localhost:5000/rfc/WBP/).
