import 'dart:html';

/**
 * A class that represents a color
 */
class Color {

    //Red
    final int r;
    //Green
    final int g;
    //Blue
    final int b;
    //Alpha
    final double a;

    /**
     * Creates a color given the RGB values
     */
    const Color(this.r, this.g, this.b, [this.a = 1.0]);

    /**
     * Gets this color as a valid JavaScript color string
     */
    String toString() => "rgba($r,$g,$b,$a)";

}

/**
 * A class that represents anything that can be drawn
 */
class Drawable {

    //The x location of the top right corner of the drawable
    int x;
    //The y location of the top right corner of the drawable
    int y;
    //The width of the drawable
    int w;
    //The height of the drawable
    int h;
    //The background color of the drawable
    Color bg;
    //The sprite of the drawable
    ImageElement sprite;

    /**
     * Creates a drawable given its location and possibly an image and/or color
     */
    Drawable(this.x, this.y, this.w, this.h, {String spriteSrc = "", this.bg = const Color(0, 0, 0, 0.0)}) {
        this.sprite = new ImageElement();
        sprite.src = spriteSrc;
    }

    /**
     * Gets the center of the drawable
     */
    List<double> center() => [this.x + this.w / 2, this.y + this.h / 2];

}