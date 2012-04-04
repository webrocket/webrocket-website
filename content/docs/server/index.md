---
title: First steps with WebRocket Server
kind:  article
group: docs
---

### Basic usage

The simplest possible usage of `webrocket-server` is just a call without
any arguments:

    $ webrocket-server
    
It will start the server with default options. It may require `sudo` on 
some operating systems while it needs access to `/var/lib/*` directory.

### Options

The most important part of WebRocket is `webrocket-server` tool. This
tool is used to preconfigure and run WebRocket nodes. Here's the short
infor how it works and how to use it.

#### Endpoints

WebRocket server tool brings up three kinds of endpoints:

* **WebSockets server** (_-websockets-addr_) - by default served on port
  8080, serves WebSockets and JavaScript client library.
* **Backend endpoint** (_-backend-addr_) - by default served on port 8081, 
  serves request-reply mechanism managing channels, broadcasting messages 
  and providing access  control. Also keeps alive and updated all the worker's
  connections.
* **Admin API** (_-admin-addr_) - RESTful interface providing easy way to 
  remote node management.

#### Storage

Server needs to store the information about vhosts, channels and access 
tokens, so it needs to have local storage directory specified. By default
data is stored under the `/var/lib/webrocket` directory. This location
can be changed with _-storage-dir_ switch.

### Node configuration

Further node configuration is made with [`webrocket-admin` tool](/docs/admin/).
Check its documentation to get know more.

### Advanced usage

To get more information about possible configuration options of `webrocket-server`
tool check its documentation, help screen (`webrocket-server -help`) or manual
pages (`man webrocket-server`).
