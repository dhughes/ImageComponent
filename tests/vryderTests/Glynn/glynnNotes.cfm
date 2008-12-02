The failing image appears to have the same mode as the succeeding image.  He saves the failing one to web-only colors, and this fixes it.  Something must be happening with the color profile apart from reducing the color count.  Additionally, the failing image works fine in pre-CF8.  Fails only since the upgrade.  Could this point to a java issue or maybe even lock horns with existing image capabilities in CF8?


Isolate the code and get it working based on java issues.

http://forums.java.net/jive/thread.jspa?messageID=244212

"reading progressive jpgs from java."


http://www.elementsvillage.com/forums/showthread.php?t=14436
color profiles # vs *


supporting color profiles with java

Progressive requires optimized... but even optimized images that do not have progressive checked don't read correctly.  It's when I uncheck optimized that it works.

