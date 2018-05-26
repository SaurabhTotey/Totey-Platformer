import 'Drawable.dart';
import 'Entity.dart';
import 'Game.dart';
import 'MovableEntity.dart';

/**
 * A class that represents a platform that is solid and collides on all sides
 */
class SolidPlatform extends Entity {

    /**
     * Constructs a solid platform given all of the dimensions
     */
    SolidPlatform(int x, int y, int w, int h) : super(x, y, w, h, spriteSrc: "res/ground.png");

    /**
     * SolidPlatforms check for collisions with the player every tick and act accordingly
     * SolidPlatforms are solid on all sides and prevent players from going through them
     */
    void act(Game game) {
        List<MovableEntity> movables = game.entities.where((Entity e) => e is MovableEntity).toList();
        movables.add(game.player);
        for (final entity in movables) {
            if (!intersect(this, entity)) {
                continue;
            }
            if (entity.center()[0] < this.x || entity.velocityX > this.w) {
                entity.velocityX = 0.0;
                entity.x = this.x - entity.w;
            }
            if (entity.center()[0] > this.x + this.w || entity.velocityX < -this.w) {
                entity.velocityX = 0.0;
                entity.x = this.x + this.w;
            }
            if (entity.center()[1] < this.y || entity.velocityY > this.h) {
                entity.velocityY = 0.0;
                entity.y = this.y - entity.h;
                entity.isGrounded = true;
            }
            if (entity.center()[1] > this.y + this.h || entity.velocityY < -this.h) {
                entity.velocityY = 0.0;
                entity.y = this.y + this.h;
            }
        }
    }

}