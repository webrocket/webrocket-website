---
title: Secured WebSockets connections
kind:  article
group: docs
---

### Setup

WebRocket supports TLS connections with a just two simple switches specified
on server startup:

    $ webrocket-server -cert=/path/to/certificate -key=/private/key
    
Specified `-cert` option must supply path to the TLS certificate we want
to use. The `-key` switch shall contain path to the private key associated
with used certificate.

That's all, after proper configuration of these two switches your server
should work on the `wss` secured protocol. 
