import 'Drawable.dart';
import 'Entity.dart';
import 'Game.dart';

/**
 * A class that represents a platform that is solid and collides on all sides
 */
class SolidPlatform extends Entity {

    /**
     * Constructs a solid platform given all of the dimensions
     */
    SolidPlatform(int x, int y, int w, int h) : super(x, y, w, h, bg: const Color(0, 255, 0));

    /**
     * SolidPlatforms check for collisions with the player every tick and act accordingly
     * SolidPlatforms are solid on all sides and prevent players from going through them
     */
    void act(Game game) {
        if (!intersect(this, game.player)) {
            return;
        }
        if (game.player.center()[0] < this.x || game.player.velocityX > this.w) {
            game.player.velocityX = 0.0;
            game.player.x = this.x - game.player.w;
        }
        if (game.player.center()[0] > this.x + this.w || game.player.velocityX < -this.w) {
            game.player.velocityX = 0.0;
            game.player.x = this.x + this.w;
        }
        if (game.player.center()[1] < this.y || game.player.velocityY > this.h) {
            game.player.velocityY = 0.0;
            game.player.y = this.y - game.player.h;
            game.player.isGrounded = true;
        }
        if (game.player.center()[1] > this.y + this.h || game.player.velocityY < -this.h) {
            game.player.velocityY = 0.0;
            game.player.y = this.y + this.h;
        }
    }

}