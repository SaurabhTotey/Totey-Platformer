import '../graphics/Drawable.dart';
import '../core/Entity.dart';
import '../core/Game.dart';

/**
 * A class that represents a heart: will increase your maximum life
 */
class Heart extends Entity {

    /**
     * Makes a heart given its locations
     */
    Heart(int x, int y): super(x, y, 25, 25, spriteSrc: "res/heart.png");

    /**
     * If a heart touches a player, they gain a life
     */
    void act(Game game) {
        if (!intersect(this, game.player) || game.player.lives >= game.player.maxLives) {
            return;
        }
        game.player.lives++;
        this.isActive = false;
    }

}