import '../graphics/Drawable.dart';
import 'Game.dart';

/**
 * A class that represents a game object
 */
abstract class Entity extends Drawable {

    //Whether the entity is active regards whether it is being used, or whether it should be discarded if inactive
    bool isActive = true;

    /**
     * Makes an entity given its location and possibly how it looks
     */
    Entity(int x, int y, int w, int h, {String spriteSrc = "", Color bg = const Color(0, 0, 0, 0.0)}) : super(x, y, w, h, spriteSrc: spriteSrc, bg: bg);

    /**
     * What the entity does every tick given the game
     */
    void act(Game game);

}