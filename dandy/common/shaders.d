module dandy.common.shaders;

import dandy.gl.shaders;
import dandy.gl.buffers;

public auto createSimpleSpriteProgram(){
    return new ShaderProgramWithBuffers([
            Shader(ShaderType.VERTEX,q{
#version 330 core
                layout(location=0) in vec2 VertexPosition;
                layout(location=1) in vec2 VertexUV;
                uniform vec2 mover;
                uniform mat2 rotator;
                uniform vec2 texStart;
                uniform vec2 texDim;
                out vec2 UV;
                void main(){
                    gl_Position.xy=rotator*VertexPosition+mover;
                    UV=texStart+texDim*VertexUV;
                }
                }),
            Shader(ShaderType.FRAGMENT,q{
#version 330 core
                in vec2 UV;
                uniform sampler2D textureSampler;
                out vec3 color;

                void main(){
                    color=texture(textureSampler,UV).rgb;
                }
                }),
            ],[
            new ArrayBuffer([
                    -0.5f,-0.5f,
                    0.5f,-0.5f,
                    0.5f,0.5f,
                    -0.5f,0.5f,
                    ]),
            new ArrayBuffer([
                    0f,0f,
                    1f,0f,
                    1f,1f,
                    0f,1f,
                    ]),
            ]);
}
