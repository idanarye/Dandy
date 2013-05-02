module dandy.gl.buffers;

import derelict.opengl3.gl3;

/**
 * An OpenGL array buffer.
 */
public class ArrayBuffer{
    GLuint bufferId;

    ///C'tor - creates a buffer from values.
    public this(float[] values){
        glGenBuffers(1,&bufferId);
        glBindBuffer(GL_ARRAY_BUFFER,bufferId);

        glBufferData(
                GL_ARRAY_BUFFER,
                float.sizeof*values.length,
                values.ptr,
                GL_STATIC_DRAW);
    }

    ///Binds the buffer.
    public void bind(){
        glBindBuffer(GL_ARRAY_BUFFER,bufferId);
    }

    ///Send the buffer to the current program, at the specified location.
    public void sendToProgram(int location){
        bind();
        glVertexAttribPointer(
                location,
                2,
                GL_FLOAT,
                GL_FALSE,
                0,
                cast(void*)0,
                );
    }
}
