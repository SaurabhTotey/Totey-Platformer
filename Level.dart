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
    //The background image; won't be stretched to fit background, but will be parallaxed
    Drawable background;
    //The amount of any dimension of the background that is visible at any given point in time; the closer to 1 this is, the more drastic the parallax will be
    double backgroundVisibility;
    //The level's acceleration downward due to gravity
    double gravity;

    /**
     * Creates a level given all of the level fields
     */
    Level({this.width = 1600, this.height = 900, this.startingPosition = const [0, 0], this.entities = const [], this.drawables = const [], this.background = null, this.backgroundVisibility = 0.8, this.gravity = 1.0}) {
        if (this.background == null) {
            this.background = new Drawable(0, 0, this.width, this.height);
        }
    }

}