---
title: WebRocket Websockets Frontend Protocol
kind:  article
---

## WebRocket Websockets Frontend Protocol

### Abstract

The **WebRocket Websockets Frontend Protocol** (*WWFP*) is a transport layer 
protocol for exchanging messages between Browsers and the [*Websocket Endpoint*](#Generalized+architecture)
implemented by WebRocket.

### Language

The key words "MUST", "MUST NOT", "REQUIRED", "SHALL", "SHALL NOT",
"SHOULD", "SHOULD NOT", "RECOMMENDED",  "MAY", and "OPTIONAL" in this
document are to be interpreted as described in [RFC 2119](#References).

### Goals

The purpose of the protocol is to allow for bidirectional, evented
communication between Browsers and WebRocket over the [WebSockets Protocol](#References) 
using the [HTML5 WebSockets API](#References).

### Generalized architecture

WebRocket handles Clients' connections with **Websocket Endpoint**, which is an 
evented HTTP server with Websockets support which handles communication with the 
*Clients* (Browsers) over the [HTML5's WebSockets Protocol](#References). 

The endpoint's URL is combined up of a number of parts:

    [scheme]://[host]:[port]/[vhost]

<dl>
  <dt><b>scheme</b></dt> 
  <dd>Will be 'ws' for a normal connection and 'wss' for a secure.</dd>
  
  <dt><b>host</b></dt>
  <dd>Websocket Endpoint is bound there.</dd>
  
  <dt><b>port</b></dt>
  <dd>Websocket Endpoint is listening on that port.</dd>
  
  <dt><b>vhost</b></dt>
  <dd>The virtual host to connect to.</dd>
</dl>

Example:

    ws://cloud.webrocket.io:8080/echo

Protocol implements events exchanging mechanism which supports two kind of
events [Client](#Client+events) and [Server](#Server+events) specific. *Client
specific* events are those sent by the *Websocket Endpoint* to the *Client*, 
*Server specific* are those sent by the *Client* and handled by *Websocket Endpoint*.

All event messages MUST have the following [JSON](#References)-encoded format:

    #!javascript
    {
        "eventName": {
            // ... payload parameters ... 
        }
    }

First found key is treated as the event name, and it's payload as the attributes
attached to it. Other keys will be ignored. 

### Client events

The *Client events* are sent by the *Websocket Endpoint* and MUST be handled
by the *Client*. Two groups of *Client specific* events can be distinguished.

<dl>
  <dt><b>System events</b></dt>
  <dd>
    Events triggered automatically by the <em>Websocket Endpoint</em> and sent to the 
    <em>Client</em>. System event names MUST be prefixed with colon (eg. <code>:connected</code>)
    and colon is prohibited as a prefix of other event messages.
  </dd>
  
  <dt><b>Custom events (user-defined)</b></dt>
  <dd>
    User-defined events are those triggered by <em>Backend Applications</em> or other connected 
    <em>Clients</em>. <em>Custom events</em> always contains the <code>channel</code> parameter 
    in its payload. It is not possible to receive a custom event without a channel assigned. 
  </dd>
</dl>

#### Connection established

When the connection is successfully established the Server sends an event
to confirm that situation with the *Client*. Message's payload MUST contain
unique identifier of the current session

    #!javascript
    {
        ":connected": {
            "sid": "session-id"
        }
    }

<dl>
  <dt><strong>sid</strong> [string]</dt>
  <dd>An unique identifier of the current session.</dd>
</dl>

#### Successfull authentication

When connected *Client* has been successfully authenticated, then the *Server*
SHALL send an event to confirm that situation. Message's payload MAY contain 
additional information about the authenticated session.

    #!javascript
    {
        ":authenticated": {}
    }

#### Confirmed subscription

When connected *Client* has successfully subscribed to the specified channel 
the *Server* SHALL send an event to confirm that situation. Message's payload 
MUST contain the name of the subscribed channel.

##### Basic format

    #!javascript
    {
        ":subscribed": {
            "channel": "channel-name"
        }
    }

<dl>
  <dt><strong>channel</strong> [string]</dt>
  <dd>The name of the subscribed channel.</dd>
</dl>

##### Private channel subscription

There is no extra parameters for private channel subscription.

##### Presence channel subscription

The *Presence channel* is a special kind of channel, which keeps track of all 
*Clients* subscribed on it and shares that information across all other subscribers. 
In that case, the message's payload MUST contain list of subscribers with their 
*Unique name identifiers* (*UID*) - which is an user-defined name used to mark and 
distinguish connected *Clients*.

The subscribers' entries MAY additionally contain custom data about a particular
subscriber.

    #!javascript
    {
        ":subscribed": {
            "channel": "channel-name",
            "subscribers": [
                {
                    "uid": "unique-user-id",
                    // ... custom information ...
                },
                // ...
            ]
        }
    }

<dl>
  <dt><strong>channel</strong> [string]</dt>
  <dd>The name of the subscribed channel.</dd>
  
  <dt><strong>subscribers</strong> [array]</dt>
  <dd>List of active subscribers (the <em>Clients</em> present on the channel</em>).</dd>
  
  <dt><strong>subscribers.uid</strong> [string]</dt>
  <dd>An unique identifier of the subscriber.</dd>
</dl>

<div class="box warning">
  List of subscribers does not contain the <em>Client</em> requesting subscription. It contains
  only list of the subscribers present on the channel just before this <em>Client</em> joined it.
  
  The <em>Client</em> SHALL get another message confirms that he 
  <a href="#Member+joined+presence+channel">which joined the channel</a>. 
</div>

#### Presence channel activity

Subscribers activity on the presence channel MUST be populated across all other 
subscribers using special events triggered when the *Client* joined and left the
channel.

#### Member joined presence channel

When new subscriber joined the presence channel the triggered event MUST contain 
the subscriber's unique identifier, and MAY contain additional, custom information
related to the subscriber. 

    #!javascript
    {
        ":memberJoined": {
            "uid": "unique-user-id",
            "channel": "channel-name",
            // ... custom information ...
        }
    }

<div class="box note">
  Additional information in the message's payload are those passed by the <em>Client</em>
  when subscribing to the channel.
</div>

<dl>
  <dt><strong>uid</strong> [string]</dt>
  <dd>An unique identifier of the subscriber.</dd>

  <dt><strong>channel</strong> [string]</dt>
  <dd>The name of the subscribed channel.</dd>
</dl>

#### Subscriber left presence channel

When connected subscriber left a channel, the triggered event MUST contain the subscriber's
unique identifier and MAY contain extra information related to the subscriber.

    #!javascript
    {
        ":memberLeft": {
            "uid": "unique-user-id",
            "channel": "channel-name",
            // ... custom information ...
        }
    }

<div class="box note">
  Additional information in the message's payload are those passed by the <em>Client</em> when 
  subscribing to the channel, merged with extra parameters passed to unsubscription request.
</div>

<dl>
  <dt><strong>uid</strong> [string]</dt>
  <dd>An unique identifier of the subscriber.</dd>

  <dt><strong>channel</strong> [string]</dt>
  <dd>The name of the subscribed channel.</dd>
</dl>

#### Confirmed unsubscription

When connected *Client* has successfully unusubscribed from the specified channel 
the *Server* MUST send an event to confirm that situation. Message's payload MUST 
contain the name of the unsubscribed channel.

    #!javascript
    {
        ":unsubscribed": {
            "channel": "channel-name"
        }
    }

<div class="box warning">
  When the <em>Client</em> unsubscribes from the presence channel then only that confirmation
  is sent to him. Notification about <a href="#Subscriber+left+presence+channel">leaving
  the channel</a> is not sent then.
</div>

<dl>
  <dt><strong>channel</strong> [string]</dt>
  <dd>The name of the subscribed channel.</dd>
</dl>

#### Closed connection confirmation

When the *Client* safely closes connection the Server MUST sends an confirmation 
message. The confirmation message SHALL contain the identifier of the closed session.

    #!javascript
    {
        ":closed": {
            "sid": "session-id"
        } 
    }

<dl>
  <dt><strong>sid</strong> [string]</dt>
  <dd>An unique identifier of the current session.</dd>
</dl>

#### Error notification

When the *Server* encountered some problem while processing the *Client's* 
message then it SHALL send apropriate, explicit information to concerned client. 
The message's payload MUST contain the numeric error code and short, human readable
explanation.

    #!javascript
    {
        ":error": {
            "code": 402,
            "status": "Unauthorized"
        }
    }

<dl>
  <dt><strong>code</strong> [int]</dt>
  <dd>The numeric error code. See <a href="#Status+codes">the list of status coded</a>.</dd>
  
  <dt><strong>status</strong> [string]</dt>
  <dd>A human readable error explanation.</dd>
</dl>


### Server events

### Status codes

### References

* [Key words for use in RFCs to Indicate Requirement](http://tools.ietf.org/html/rfc2119) - S. Bradner, IETF
* [The WebSockets Protocol](http://tools.ietf.org/html/draft-ietf-hybi-thewebsocketprotocol) - I. Fette, IETF
* [The WebSockets API](http://dev.w3.org/html5/websockets/) - I. Hickson, W3C
* [JavaScript Object Notation (JSON)](http://www.ietf.org/rfc/rfc4627) - D. Crockford, JSON.org
* [HTTP Status Code Definitions](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) - W3.org

### Glossary
