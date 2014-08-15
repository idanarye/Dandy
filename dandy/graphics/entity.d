module dandy.graphics.entity;

import std.typecons;

import gl3n.linalg;

import dandy.util.all;
import dandy.graphics.base;

public abstract class GEntity{
    mixin attribute!(IDrawable,"drawable");

    public this(IDrawable drawable){
        m_drawable=drawable;
    }

    protected abstract Tuple!(vec2,mat2) calcPosAndRot();

    public void draw(){
        m_drawable.drawAt(calcPosAndRot().expand);
    }
}
