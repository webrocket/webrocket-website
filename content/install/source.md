---
title: Installation from source
kind:  article
group: docs
---

To install WebRocket from source you need the following tools and dependecies:

### Go 1 compiler

WebRocket is written in the Go programming language. Obviously you need to
have it installed on your machine in order to compile WebRocket. If you already
installed it, make sure that your version is supported by WebRocket.

#### Installing Go

Get latest version of Go compiler and follow [this installation instructions](http://golang.org/doc/install).
After the installation is complete, you need to set few environment variables
in your `~/.bashrc` file (or other shell confuguration file):

    #!bash
    export GOROOT=/path/to/go
    export GOBIN=$GOROOT/bin
    export GOPATH=~/go/workspace
    export PATH=$GOBIN:$GOPATH/bin:$PATH

If your Go version has been installed via operating system's package manager,
then I assume that `GOROOT` and `GOBIN` variables are set correctly, so the
only thing you need to do is to set `GOPATH` variable. The `GOPATH` reffers
to place where Go packages and dependencies will be installed. 
	
If you have any other doubts or problems please follow the instructions
in Go's documentation or get more information [how to write Go code](http://golang.org/doc/code.html).

### Building WebRocket

Once you have the Go compiler and all dependencies installed, we can move
to building our WebRocket installation. Building WebRocket is very easy and
shouldn't cause too many problems. 

The simplest way to install WebRocket is to use `go install` tool:

    $ go install github.com/webrocket/webrocket
    
You can also install it manually. Download [latest version](/releases/webrocket/webrocket-<%= $WEBROCKET_LATEST_VERSION %>.tar.gz)
of WebRocket server, unpack it to `~/go/workspace/github.com/webrocket/webrocket/`
and follow standard steps:

	$ make
    $ make install
    
### Troubleshooting

If you encountered any problem during the installation see the <a href="/install/troubles/">troubleshooting</a>
article. If you can't find solution of your problem there, please let us know about it by creating
an [issue on github](http://github.com/webrocket/webrocket/issues).
