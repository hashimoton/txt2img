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

.. image:: https://user-images.githubusercontent.com/5894641/75097780-fbe83580-55f1-11ea-865d-e7adadba259d.png

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

  $ txt2img -w 100 -h 200 -k RGB,PNG lib/txt2img.rb
  
.. image:: https://user-images.githubusercontent.com/5894641/75097839-87fa5d00-55f2-11ea-97ca-1912bb96ac93.png

Keywords RGB and PNG are highlighted with different colors.

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

3. Add txt2img/bin to your PATH



.. EOF


