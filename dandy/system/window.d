module dandy.system.window;

import std.string;
import core.thread;

import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;

import dandy.system.system;
import dandy.util;

/**
 * Represents a single window. Can only have one per thread.
 */
class Window{
    private GLFWwindow* m_window;

    mixin Singleton;

    ///Init the window.
    public static void init(int screenWidth,int screenHeight,string title=""){
	singleton_initInstance(new Window(screenWidth,screenHeight,title));
    }

    private this(int screenWidth,int screenHeight,string title){
	m_window=glfwCreateWindow(
		screenWidth,
		screenHeight,
		title.toStringz(),null,null);

	glfwWindowHint(GLFW_VERSION_MAJOR, 3);
	glfwWindowHint(GLFW_VERSION_MINOR, 3);
	//glfwWindowHint(GLFW_RESIZABLE,false);

	glfwMakeContextCurrent(m_window);
	DerelictGL3.reload();
    }
    private ~this(){
	if(m_window){
	    //glfwDestroyWindow(m_window);
	    //m_window=null;
	}
    }

    ///Calls the main loop of the window
    public void loop(){
	while(0==glfwGetKey(m_window,GLFW_KEY_ESC)){
	    glfwPollEvents();
	    glClearColor( 0.0f, 0.0f, 0.0f, 0.0f );
	    glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT);
	    glfwSwapBuffers(m_window);
	    Thread.sleep(dur!"msecs"(50));
	}
    }
}
