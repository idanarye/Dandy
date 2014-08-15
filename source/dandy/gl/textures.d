module dandy.gl.textures;

import std.string;

import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;
import derelict.freeimage.freeimage;

import dandy.loading.resouces;

/**
 * Base interface for textures.
 */
public interface ITexture{
    ///Bind the texture
    public void bind();
}

/**
 * A texture that can be loaded from a source file.
 */
public class TextureFromFile:Resource,ITexture{
    private string sourceFile;
    private GLuint textureId;
    private GLenum textureFormat;
    private GLuint nOfColors;
    private int sizex,sizey;

    public this(string sourceFile){
        this.sourceFile=sourceFile;
        textureId=0;
    }

    public override void load(){
        if(textureId) return;

        auto fileNameCStyle=sourceFile.toStringz();
        auto fiImage=FreeImage_Load(FreeImage_GetFileType(fileNameCStyle,0),fileNameCStyle,0);
        auto imageData=FreeImage_GetBits(fiImage);

        glGenTextures(1,&textureId);
        glBindTexture(GL_TEXTURE_2D,textureId);

        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_S,GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_WRAP_T,GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
        glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);

        sizex=FreeImage_GetWidth(fiImage);
        sizey=FreeImage_GetHeight(fiImage);

        int sourceColorFormat=0;
        int targetColorFormat=0;
        switch(FreeImage_GetColorType(fiImage)){
            case FIC_RGB:
                targetColorFormat=GL_RGB;
                version(LittleEndian) sourceColorFormat=GL_BGR;
                break;
            case FIC_RGBALPHA:
                targetColorFormat=GL_RGBA;
                version(LittleEndian) sourceColorFormat=GL_BGRA;
                break;
            default:
        }

        if(0==sourceColorFormat)
            sourceColorFormat=targetColorFormat;

        glTexImage2D(GL_TEXTURE_2D,0,targetColorFormat,sizex,sizey,
                0,sourceColorFormat,GL_UNSIGNED_BYTE,imageData);

        glGenerateMipmap(GL_TEXTURE_2D);

        FreeImage_Unload(fiImage);
    }


    public override bool isLoaded(){
        return 0!=textureId;
    }

    public void bind(){
        glBindTexture(GL_TEXTURE_2D,textureId);
    }
}
