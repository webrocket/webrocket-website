---
title: Remote administration and security
kind:  article
group: docs
---

### Security

Admin access to WebRocket nodes is limited by server cookies. When `webrocket-server`
starts for the first time it generates cookie file (usually under `/var/lib/webrocket/$HOSTNAME.cookie`)
which contains cookie hash. This cookie has to be used to perform any remote
admin operation.

If `webrocket-admin` is used to configure local instances, then local cookie file
is used automatically to access the node.

### Remote administration

In case when you want to manage remote node few additional options has to be provided:

    $ webrocket-admin -node=node-host-name -cookie=cookie-hash action [args...] 
    
Also `-admin-addr` option can be used instead of (or together with) `-node` switch.
The `node-host-name` is the host name specified in hosts configuration (`/etc/hosts`)
for the remote server's IP address. Cookie hash can be read from the server's cookie
file:

    $ cat /var/lib/webrocket/$HOSTNAME.cookie

Cookie can also be read from the `webrocket-server` startup message - all the information
like hostname, cookie and endpoints' binding can be found there.
    
This few extra parameters allows to manage any remote WebRocket server. Remember
that your server's firewall must allow for connection from your machine or
keep the admin endpoint's port open.
