module dandy.gl.shaders;

import std.stdio;
import std.conv;

import derelict.opengl3.gl3;

import gl3n.linalg;

import dandy.gl.buffers;

public enum ShaderType{VERTEX,FRAGMENT}

private auto @property shaderTypeGLValue(ShaderType type){
    final switch(type){
        case ShaderType.VERTEX:   return GL_VERTEX_SHADER;
        case ShaderType.FRAGMENT: return GL_FRAGMENT_SHADER;
    }
}

/**
 * Represents a shader.
 *
 * Send to a ShaderProgram and then let RAII destroy it.
 */
public struct Shader{
    private GLuint m_shaderType;
    private GLuint m_shaderId;

    ///Create a shader with the specified type and the supplied code.
    this(ShaderType shaderType,string code){

        m_shaderType=shaderType;
        m_shaderId=glCreateShader(shaderType.shaderTypeGLValue);

        char[] shaderCode=new char[code.length+1];
        shaderCode[]=code~"\0";

        char* shaderPointer=shaderCode.ptr;

        glShaderSource(m_shaderId,1,&shaderPointer,null);
        glCompileShader(m_shaderId);

        GLint result=GL_FALSE;
        int infoLogLength;

        glGetShaderiv(m_shaderId,GL_COMPILE_STATUS,&result);
        glGetShaderiv(m_shaderId,GL_INFO_LOG_LENGTH,&infoLogLength);

        char[] shaderErrorMessage=new char[infoLogLength];
        glGetShaderInfoLog(m_shaderId,infoLogLength,null,shaderErrorMessage.ptr);

        if(GL_TRUE!=result)
            throw new Exception("Shader Error:\t"~text(shaderErrorMessage));
    }
    ~this(){
        glDeleteShader(m_shaderId);
    }
}

/**
 * A shader program.
 */
public class ShaderProgram{
    public immutable GLuint programId;
    private SingleUniform[string] m_uniforms;

    ///Create the shader program from the supplied shaders.
    this(Shader[] shaders...){
        programId=glCreateProgram();
        foreach(shader;shaders)
            glAttachShader(programId,shader.m_shaderId);
        glLinkProgram(programId);

        GLint result=GL_FALSE;
        int infoLogLength;

        glGetProgramiv(programId,GL_LINK_STATUS,&result);
        glGetProgramiv(programId,GL_INFO_LOG_LENGTH,&infoLogLength);

        char[] programErrorMessage=new char[infoLogLength];
        glGetShaderInfoLog(programId,infoLogLength,null,programErrorMessage.ptr);

        if(GL_TRUE!=result)
            throw new Exception("ShaderProgram Error:\t"~text(programErrorMessage));

        buildUniformsHash();
    }

    ///Tell OpenGL to use the program.
    void use(){
        glUseProgram(programId);
    }

    ///Get an OpenGL shader program parameter.
    GLint getParameter(GLenum paramName){
        GLint result=0;
        glGetProgramiv(programId,paramName,&result);
        return result;
    }

    private void buildUniformsHash(){
        GLsizei length;
        GLint size;
        GLenum type;
        GLchar[256] name;
        for(int i=0;i<getParameter(GL_ACTIVE_UNIFORMS);++i){
            glGetActiveUniform(programId,i,name.length,&length,&size,&type,name.ptr);
            auto nameAsString=(cast(char*)name).to!string();
            m_uniforms[nameAsString]=SingleUniform(nameAsString,i,size,type);
        }
    }

    private struct SingleUniform{
        immutable string name;
        immutable GLuint index;
        immutable GLint size;
        immutable GLenum type;
    }

    ///Set a value to a uniform.
    public void uniform(string uniformName,vec2 value){
        glUniform2f(m_uniforms[uniformName].index,value.x,value.y);
    }

    ///ditto
    public void uniform(string uniformName,mat2 value){
        glUniformMatrix2fv(m_uniforms[uniformName].index,1,true,value.value_ptr);
    }
}

/**
 * A ShaderProgram, together with some buffers.
 */
public class ShaderProgramWithBuffers:ShaderProgram{
    private ArrayBuffer[] m_buffers;
    ///Create the shader program from the supplied shaders and buffers.
    public this(Shader[] shaders,ArrayBuffer[] buffers){
        super(shaders);
        m_buffers=buffers;
    }

    ///Bind the buffers
    void bindBuffes(){
        foreach(index,buffer;m_buffers){
            glEnableVertexAttribArray(cast(uint)index);
            buffer.sendToProgram(cast(uint)index);
        }
    }

    ///Unbind the buffers
    void unbindBuffers(){
        foreach(index,buffer;m_buffers){
            glDisableVertexAttribArray(cast(uint)index);
        }
    }
}
