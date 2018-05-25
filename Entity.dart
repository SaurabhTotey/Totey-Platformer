import 'Drawable.dart';

/**
 * A class that represents a game object
 */
abstract class Entity extends Drawable {

    /**
     * Makes an entity given its location and possibly how it looks
     */
    Entity(int x, int y, int w, int h, {String spriteSrc = "", Color bg = const Color(0, 0, 0, 0.0)}) : super(x, y, w, h, spriteSrc: spriteSrc, bg: bg);

    /**
     * What the entity does every tick
     */
    void act();

}