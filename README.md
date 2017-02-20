Test repo to work out why the [logging-effect](https://github.com/ocharles/logging-effect) is not doing what I think it is. See Ticket [#14](https://github.com/ocharles/logging-effect/issues/14). 

#Findings

There isn't a promlem with the logging-effect library!

It looks like there is an interaction between `BatchingOptions` and the fact that stdout is, by default, buffered.


## With Buffering

NOTE: I'm using the following batch options:

```haskell
BatchingOptions {flushMaxDelay = 0, flushMaxQueueSize = 1, blockWhenFull = True}
```

The code will log a message every second but will only output those messages when stdout's buffer is full. If I set the buffering to `NoBuffering` or `LineBuffering` a log message is output every message. This is also true if I set stdout's buffer size to exactly the length of the log message. If I set the log message to twice the size of the log message then messages are output in pairs. If I set stout's buffer to three times the size of the log message then messages are output in groups of three and so on.

I think this is a pretty clear demonstration of what's going on.


I think the following [quote](https://hackage.haskell.org/package/base-4.9.1.0/docs/System-IO.html#g:12) sums it up quite well:

>  ... For most implementations, physical files will normally be block-buffered and terminals will normally be line-buffered.
