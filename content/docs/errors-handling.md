---
title: Errors handling
kind:  article
group: docs
---

### General approach

WebRocket comes with very liberal policy of errors handling. The main idea
of error handling in frontend client is to not handle them at all, when 
backend clients provide the way to handle errors in handy way.

<a href="#" name="Frontend"></a>

### Frontend (JavaScript) client

There are two kind of errors to distinguish: **errors caused by bugs in
the code**, and **errors caused by interrupted connection or data loss**.
WebRocket server and client design encoureges to use bugs related errors
only for development purposes and don't realy on them in the production
code. WebRocket provides even way to disable error notifications in
production environment. The only and only error which should be handled
in the production code is **on disconnect**:

    #!javascript
    var wr = new WebRocket('ws://localhost:8080/vhost');
    wr.bind(':disconnected', function() {
        // reconnect, notify about getting offline or do whatever you want. 
    });
    
    // *snip*
    
    wr.connect();
    
For the client there's no difference why connection has ben broken. The
only thing that matter is that socket is disconnected and some action
has to be performed. What to do in that situation is **user decision**.
WebRocket tries to reconnect for three times before it will trigger
`disconnected` event. After that user may decide if he want to keep 
reconnecting automatically, notify user about the problem or not take
any actions at all.

<blockquote>
  What about mesage delivery errors?
</blockquote>

There's none. WebRocket is fully fault tollerant that's why its so fast,
it doesn't tag the message, it doesn't track it and doesn't notify
when message has been lost or not. Such operations are very costfull and
hard to implement, and usually not needed in most of the systems. If you
really need to track if messages has been delivered or not, then you
can implement your own mechanism of messages tracking, eg. based on
direct acknowledge responses. You can read about it further in [advanced
messaging](/docs/advanced-messaging/) section.

<a href="#" name="Backend"></a>

### Backend Worker (SUB)

Worker, depending on the implementation provides a way to handle errors
and deal with them. However, the same as with frontend client, we encourage
you to not realy on this errors. This kind of errors **are only notifications 
that something went wrong** and that's **programmer's fault**. Example in Go:

    #!go
    w := kosmonaut.NewWorker("wr://{token...}@127.0.0.1:8081/hello")
    for msg := range w.Run() {
            if msg.Error == nil {
                    fmt.Println(msg.Event)
            }
            // else... something went wrong, most probably incoming is 
            // corrupted or has invalid format.
    }

### Backend Client (REQ)

Backend client, depending on the implementation, raises appropriate exception
or returns appropriate error which can be handled. Backend client is the
only component which requires 100% reliability. Imagine, nothing bad will
happen if message from javascript client will be lost (in most of cases),
but if messages broadcasted from the backend will not be reliable then it
may affect whole the system in a very bad way. That's why Backend Client's 
error handling is on a very good level and provides 100% reliability. Example:

    #!go
    err := c.OpenChannel("world")
    if err != nil {
            println(err.String());
    }

Backend client errors provides very comprehensive information what happened,
depending on the implementation there's a way to get the error code and 
textual status information.

### WebRocket server

WebRocket server is the place where all the errors are handled and logged.
If you need to get detailed information about what wrong happend in the
system you can easily get it from WebRocket access logs.
