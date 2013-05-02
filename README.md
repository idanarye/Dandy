Dandy
=====

A 2D game engine for D.

Requirements
============

Compiled with DMD2

Derelict3
---------
Download and compile Derelict3: <http://www.dsource.org/projects/derelict>

Link to these:

* DerelictUtil
* DerelictFI
* DerelictGLFW3
* DerelictGL3
* DerelictAL

Ofcourse, you'll need FreeImage, GLFW3, OpenGL and OpenAL installed on the
computer or have their DLLs in the folder.

LuaD
----
Just download it: <https://github.com/JakobOvrum/LuaD>

Look under the **Usage** section in *LuaD*'s readme to know what files you need to compile.

To compile
----------

Copy `paths.d.template` to `paths.d,` and change in `paths.d` the paths to
where the librarie's are installed. After that, Use `rdmd build.d`. You can and
should supply the following flags(using D's
[std.getopt.getopt](http://dlang.org/phobos/std_getopt.html#.getopt)
conventions):

* `input` or `i`: Extra files to compile together with the program.
* `output` or `o`: Where to put the binaries.
