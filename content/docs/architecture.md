---
title: Understanding the architecture
kind:  article
group: docs
---

### Main components

WebRocket is a hybrid server, composed from two endpoints: **WebSockets server**
and **Backend endpoint**. Such design allows to bidirectionally communicate
between browsers supporting WebSockets and any kind of backend web application
or daemon.

#### WebSockets endpoint

WebSockets server is very fast, high performance HTTP server supporting
latest version of the WebSockets specification. It communicates with browsers
using custom [WebRocket WebSockets Frontend Protocol](/rfc/WWFP/). This
protocol is the most important part of the WebRocket. It has been designed
as open standard, and optimized for speed and reliability.

#### Backend endpoint

Backend's dispatcher distinguishes two kinds of sockets: **Worker (SUB)**
and **Client (REQ)**. They're both well descirbed in [the concept of Kosmonaut](/docs/kosmonaut/)
document. Backend utilizes its own, simple text protocol: [WebRocket Backend Protocol](/rfc/WBP).

### How it works?

It's very simple, we can describe it in three bullet points:

* Browsers connected to WebSockets endpoints - each of them can subscribe
  many channels, receive and broadcast messages, and trigger background
  (backend) jobs.
* Clients (REQ) are used to manage channels, broadcast information from backend
  applications and provide authentication. Each client sends requests to
  the Backend endpoint and waits for the answer.
* Workers (SUB) are used to listen for triggered operations. Each worker
  listens to messages sent from Browsers. When message is received then dispatches
  it to appropriate handler.
  
Besides, backend Clients are reliable and safe, Workers are fault tollerant 
and very cheap to setup.

### Vhosts, channels, subscriptions

WebRocket environment is made up from **vhosts** and **channels**.

**Vhost** is an encapsulated, standalone placeholder for the channels and
user specicif configuration. One WebRocket cluster can contain many unrelated
vhosts with totally unrelated channels, subscribers, workers and configuration.

**Channel** is a publish-subscribe construct on which whole the idea of
WebRocket is based. Clients can subscribe specified channels and get updates
from it whenever new information will be broadcasted there. WebRocket supports
three types of channels - **open**, **private**, and **presence** (private 
channels which track list of subscribers).

**Subscription** is a relation between client and channels. Each connection 
can **subscribe to many channels** of different type. 

### Bidirectional communication

This architecture makes WebRocket very reliable broker providing real, bidirectional
communication between Browsers and any kind of backend application supporting
WebRocket Backend Protocol. It can also work as a standalone WebSockets
server when communication with backend is not needed.

### Scalability

WebRocket has been designed to make horizontal scalability easy and harmless.
Setting up your own WebSockets server is costful and difficult, it requires
knowledge about messaging, setting external broker (eg. RabbitMQ) to communicate
between instances and so on. WebRocket has ben designed for this - to make
WebSockets server scallable and easy to configure.

### WebRocket in one sentence

WebRocket architecture can be described by one sentence only, that's actually
all you have to know at this point:

<blockquote>
  WebRocket is a distributed WebSockets broker, which provides real and cheap
  bidirectional communication between browsers and application's backend.
</blockquote>

Nothing more to say...
