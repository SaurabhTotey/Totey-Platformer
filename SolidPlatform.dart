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
        if (game.player.y + game.player.h < this.y || game.player.y > this.y + this.h) {
            if (game.player.velocityX > 0) {
                game.player.x = this.x - game.player.w;
            } else if (game.player.velocityX < 0) {
                game.player.x = this.x + this.w;
            }
        } else {
            if (game.player.velocityY > 0) {
                game.player.y = this.y - game.player.h;
            } else if (game.player.velocityY < 0) {
                game.player.y = this.y + this.h;
            }
        }
    }

}