************
img2txt
************

A text rasterizer


img2txt generages a kind of bitmap image from text files.

Each pixel corresponds to a single character in the text files.
The pixel color represents character categories.


===========
Usage
===========

Default
---------------

::

  txt2img access.log

The tool generates txt2img.png in current working directory.

Only the first 1000 lines are used.
For each line. the first 200 characters are used.


Help
---------------
::

  $ txt2img --help
  Usage: txt2img [options] FILE [FILE...]

  Options:
      -w=WIDTH                         Width (default: 200)
      -h=HEIGHT                        Height (default: 1000)
      -k=KEYWORDS                      Keyword1,keyword2,... (no default)
      -o=OUTPUT_FILE                   Output PNG file (default: txt2img.png)

Example
-------------

::

  $ txt2img -w100 -h 200 -k RGB,PNG lib/txt2img.rb


==========
Setup
==========

Prerequisites
-----------------

* Tested with Ruby 2.6.5

* RubyGems: ChunkyPNG_ , rgb_

.. _ChunkyPNG: https://github.com/wvanbergen/chunky_png
.. _rgb: https://github.com/plashchynski/rgb


Install
------------------

1. Download txt2img archive.

2. Extract the archive to your convenient directory.

2. Add txt2img/bin to your PATH



.. EOF

