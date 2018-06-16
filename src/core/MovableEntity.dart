import 'dart:math';
import '../graphics/Drawable.dart';
import 'Entity.dart';
import 'Game.dart';

/**
 * The class that represents any movable entity in the game
 */
class MovableEntity extends Entity {

    //The x component of the entity's velocity
    double velocityX;
    //The y component of the entity's velocity
    double velocityY;
    //Whether the entity is on the ground or not
    bool isGrounded = false;

    /**
     * Makes an entity given its starting position and velocity
     */
    MovableEntity(int x, int y, int w, int h, {this.velocityX = 0.0, this.velocityY = 0.0, String spriteSrc = "", Color bg = const Color(0, 0, 0, 0.0)}) : super(x, y, w, h, spriteSrc: spriteSrc, bg: bg);

    /**
     * What the entity does every tick
     * Just moves by its velocity
     */
    void act(Game game) {
        this.x = (this.x + this.velocityX).round();
        this.y = (this.y + this.velocityY).round();
        this.velocityY += game.level.gravity;
    }

    /**
     * Gets the entity's speed or magnitude of its velocity
     */
    double speed() => sqrt(pow(this.velocityX, 2) + pow(this.velocityY, 2));

    /**
     * Gets the entity's direction of movement in radians that go clockwise
     */
    double direction() => atan2(velocityY, velocityX);

}