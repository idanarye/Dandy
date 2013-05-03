Dandy
=====

A 2D game engine for D.

Requirements
============

You'll need to install:

* [Git](http://git-scm.com/)
* [dmd2](http://dlang.org/download.html)
* OpenGL - should be installed by the drivers of your Graphics Card provider.
* [gflw3](https://github.com/glfw/glfw)
* [FreeImage](http://freeimage.sourceforge.net/)

To compile
==========

Use `rdmd deps.d` to get and 

Use `rdmd build.d` to compile. You can and should supply the following
flags(using D's
[std.getopt.getopt](http://dlang.org/phobos/std_getopt.html#.getopt)
conventions):

* `input` or `i`: Extra files to compile together with the program.
* `output` or `o`: Where to put the binaries.
