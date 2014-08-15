module dandy.graphics.sprite;

import std.typecons;

import gl3n.linalg;

import dandy.util;
import dandy.graphics;

public class FreeSprite:GEntity{
    mixin attribute!(vec2,"pos");
    mixin attribute!(mat2,"rot");

    public this(IDrawable drawable,vec2 pos,mat2 rot=mat2.identity){
        super(drawable);
        m_pos=pos;
        m_rot=rot;
    }

    override protected Tuple!(vec2,mat2) calcPosAndRot(){
        return tuple(pos,rot);
    }
}
