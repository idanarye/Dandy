module dandy.graphics.base;

import gl3n.linalg;

public interface IDrawable{
    public void drawAt(vec2 position,mat2 rotation=mat2.identity);
}
