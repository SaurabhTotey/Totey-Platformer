import 'Drawable.dart';
import 'Entity.dart';

/**
 * A class that represents a level in the game
 * Defines the layout and objects in the level
 */
class Level {

    //How wide the level is
    int width;
    //How tall the level is
    int height;
    //Where the player starts
    List<int> startingPosition;
    //All the static entities that are in the level: entities store their layout
    List<Entity> entities;
    //All the static drawables that are in the level: only affect appearance
    List<Drawable> drawables;
    //The level's acceleration downward due to gravity
    double gravity;

}