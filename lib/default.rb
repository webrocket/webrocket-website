# All files in the 'lib' directory will be loaded
# before nanoc starts compiling.

WEBROCKET_VERSIONS = [
  "0.3.0"                      
]

WEBROCKET_LATEST_VERSION = WEBROCKET_VERSIONS.last

NOT_READY = <<P
<div class="not_ready_yet">
  <p>This article has not been written yet. Please wait, it will appear soon.</p>
  <p class="help">Oh, meanwhile you can help us write it! Just <a href="http://github.com/webrocket/webrocket-website/">fork this page on github</a>!</p>
</div>
P
