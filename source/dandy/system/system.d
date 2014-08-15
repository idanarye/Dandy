module dandy.system.system;

import std.stdio;
import std.algorithm;
import core.thread;

import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;
import derelict.freeimage.freeimage;

import dandy.util;
import dandy.system.window;

/**
 * Handles the library initialization.
 */
class System{
    private this(){}

    ///Initializes all the libraries.
    public static static void init(){
        DerelictGL3.load();
        DerelictGLFW3.load();
        DerelictFI.load();

        if(0>glfwInit())
            throw new Exception("Unable to load GLFW!");

        FreeImage_Initialise(false);
    }

    ///Releases all the libraries.
    public static void destroy(){
        FreeImage_DeInitialise();
        glfwTerminate();
    }
}
