---
title: Installation from source
kind:  article
---

To install WebRocket from source you need the following tools and dependecies:

### Latest Go compiler (supported weekly.2012-01-27)

WebRocket is written in the Go programming language. Obviously you need to
have it installed on your machine in order to compile WebRocket. If you already
installed it, make sure that your version is supported by WebRocket.

#### Installing Go

To get and build a Go version working with current WebRocket implementation,
follow this instructions:

    $ hg clone https://go.googlecode.com/hg/ go
    $ hg checkout weekly.2012-01-27
    $ cd go/src
    $ ./all.bash

When the build succeeds you need to add few environment variables to your
'~/.bashrc' (or other shell configuration file):

    #!bash
    export GOROOT=/path/to/go
    export GOOS=os-name # darwin, linux, freebsd...
    export GOARCH=arch-name # amd64 or i386
    export GOBIN=$GOROOT/bin
    export PATH=$GOBIN:$PATH
	
If you have any other doubts or problems please follow the instructions
in Go's documentation.

### Dependencies

Since Go weekly moved 'websocket' package to subprepository, you have to
additionally goinstall it:

    $ go install code.google.com/p/go.net/websocket

### Building WebRocket

Once you have the Go compiler and all dependencies installed, we can move
to building our WebRocket installation. Building WebRocket is very easy and
shouldn't cause too many problems. 

Download [the latest version](/releases/webrocket/webrocket-<%= $WEBROCKET_LATEST_VERSION %>.tar.gz)
of WebRocket server, unpack it and follow standard steps:

    $ ./configure
	$ make
    $ sudo make install
    
It's also a good idea to run tests, you can do it with `check` target:

	$ make check

### Troubleshooting

If you encountered any problem during the installation see the <a href="/install/troubles/">troubleshooting</a>
article. If you can't find solution of your problem there, please let us know about it by creating
an [issue on github](http://github.com/webrocket/webrocket/issues).
