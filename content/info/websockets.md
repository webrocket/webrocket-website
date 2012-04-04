---
title: WebSockets technology
kind:  article
group: docs
---

WebSocket is a web technology providing for bi-directional, full-duplex 
communications channels, over a single Transmission Control Protocol 
(TCP) socket. The WebSocket API is being standardized by the W3C, and 
the WebSocket protocol has been standardized by the IETF as RFC 6455.

### How it works?

WebSocket is designed to be implemented in web browsers and web servers, 
but it can be used by any client or server application. The WebSocket 
protocol makes possible more interaction between a browser and a web site, 
facilitating live content and the creation of real-time games. This is 
made possible by providing a standardized way for the server to send 
content to the browser without being solicited by the client, and 
allowing for messages to be passed back and forth while keeping the 
connection open. In this way a two-way (bi-direction) ongoing conversation 
can take place between a browser and the server. A similar effect has 
been done in non-standardized ways using stop-gap technologies such 
as comet.

In addition, the communications are done over the regular TCP port 
number 80, which is of benefit for those environments which block 
non-standard Internet connections using a firewall. WebSocket protocol 
is currently supported in several browsers including Firefox and Google 
Chrome. WebSocket also requires web applications on the server to be 
able to support it.

### Browser support

Chrome 16, Firefox 11 and Internet Explorer 10 are currently the only 
browsers supporting the latest specification (RFC 6455) of the WebSocket
protocol. However WebSockets fallback support can be provide in any 
browser with Adobe Flash Player installed.

### Benefits

WebSockets are very often mentioned as the technology of the future
in Web Development, heavily promoted by Mozilla and used by the biggest
players on the market like Google, Facebook and Twitter - making their
products truely real-time applications beloved by all of us. 

However implementation and maintainance of WebSockets server was very hard, 
painfull and costfull. There was few closed, hosted solutions and open 
source libraries which could help you get rid of some overhead, but still
it wasn't what we expected from this great technology. That's why
WebRocket is here, as an answer to your needs of easy to setup, scallable
and fast WebSockets server.
