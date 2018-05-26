import 'Drawable.dart';
import 'Entity.dart';
import 'Game.dart';

/**
 * An entity that when collided with signifies the end of a level
 */
class EndBlock extends Entity {

    /**
     * Constructs an EndBlock given a position
     * EndBlocks are currently black and 50 x 50
     */
    EndBlock(int x, int y) : super(x, y, 50, 50, spriteSrc: "res/rainbowSquare.png");

    /**
     * Every tick, the EndBlock checks whether it has been collided with by the player
     * If it has, it ends the game
     */
    void act(Game game) {
        if (intersect(this, game.player)) {
            game.isFinished = true;
        }
    }

}