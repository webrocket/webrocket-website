---
title: Kosmonaut for Go
kind:  article
group: docs
---

### Status

Kosmonaut version for for ruby is an **official** client. It is considered
to be stable and we're encouraging you to use it.
 
### Installation

Package is goinstallable, you can install it with the following command:

    $ go install github.com/webrocket/webrocket/pkg/kosmonaut
    
The package is also distributed with webrocket server, so if you have
webrocket server already installed from source then kosmonaut should be
there as well. 

### Usage

Request clients are very simple to use. Here's trivial example:

    #!go
    c := kosmonaut.NewClient("wr://{token...}@127.0.0.1:8081/hello")
    c.OpenChannel("world")
    c.Broadcast("world", "greetings", map[string]interface{}{
            "from": "Chris",
            "to":   "everyone!",
    })
    
Backend worker provides the simplest functionality possible to allow
building your more sophisticated workers. Here's an example:

    #!go
    w := kosmonaut.NewWorker("wr://{token...}@127.0.0.1:8081/hello")
    for msg := range w.Run() {
            if msg.Error != nil {
                    // do something with the error...
            } else {
                    // do something with the message, eg:
                    println(msg.Event)
            }
    }

For further information check the [package documentation](http://gopkgdoc.appspot.com/pkg/github.com/webrocket/webrocket/pkg/kosmonaut).

### Troubleshooting

If you encountered any problem while using Kosmonaut for Go, please let us not about it
by creating an [issue on github](http://github.com/webrocket/webrocket/issues).
