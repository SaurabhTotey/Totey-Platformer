import 'Drawable.dart';
import 'Game.dart';
import 'MovableEntity.dart';

/**
 * The class that represents the main player of the game
 */
class Player extends MovableEntity {

    //The state of whether the player is on the ground or not: controls whether it can jump or not
    bool isGrounded = false;

    /**
     * Makes a player given its starting position; players are always 50 wide and 100 tall
     */
    Player(int x, int y) : super(x, y, 50, 100, bg: const Color(255, 100, 100));

    /**
     * Players stop their horizontal velocity every turn
     */
    void act(Game game) {
        if (this.velocityY != 0) {
            this.isGrounded = false;
        }
        super.act(game);
        this.velocityX = 0.0;
    }

}