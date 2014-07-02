obelisk
=======

Static Site Generator written in Elixir.

## Goals

* **Fast**. Static websites can take a long time to generate when they start to grow large.
obelisk should take advantage of Elixir's multithreaded behaviour to increase this speed.
* **Simple, Obvious**. It should be very straight forward to add new content and modify the 
way that your site works.
* **Templatable**. It should be possible to store templates in github repos and reference them
directly, allowing modification of the look and feel of a site instantaneously with no manual
installation.
