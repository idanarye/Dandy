module dandy.graphics.images;

import gl3n.linalg;

import dandy.gl.textures;
import dandy.gl.shaders;

/**
 * An image - a texture, rectangle on that texture, and a shader program to
 * render it.
 */
public class Image{
	private ITexture m_texture;
	private ShaderProgramWithBuffers m_program;
	vec2 m_textureTopLeft;
	vec2 m_textureWidthHeight;

	/**
	 * Create the image.
	 */
	public this(ITexture texture,vec2 textureTopLeft,vec2 textureWidthHeight,
			ShaderProgramWithBuffers program){
		m_texture=texture;
		m_program=program;
		m_textureTopLeft=textureTopLeft;
		m_textureWidthHeight=textureWidthHeight;
	}

	/**
	 * Draw the image at the specified position with the specified
	 * rotation(+scale).
	 */
	public void drawAt(vec2 position,mat2 rotation=mat2.identity){
		//import std.stdio;writeln("DRAW!");
		import derelict.opengl3.gl3;
		m_texture.bind();
		m_program.use();
		m_program.bindBuffes();
		m_program.uniform("mover",position);
		m_program.uniform("rotator",rotation);
		m_program.uniform("texStart",m_textureTopLeft);
		m_program.uniform("texDim",m_textureWidthHeight);
		glDrawArrays(GL_TRIANGLE_FAN,0,4);
		m_program.unbindBuffers();
	}
}
