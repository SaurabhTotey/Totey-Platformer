import '../graphics/Drawable.dart';
import '../core/Entity.dart';
import '../core/Game.dart';

/**
 * A class that represents a coin in the game
 * Coins are the main way of scoring the level
 */
class Coin extends Entity {

    /**
     * Makes a coin given its location
     */
    Coin(int x, int y): super(x, y, 25, 25, spriteSrc: "res/coin.png");

    /**
     * If a coin touches a player, the coin disappears and the player gets the coin
     */
    void act(Game game) {
        if (!intersect(this, game.player)) {
            return;
        }
        game.player.coins++;
        this.isActive = false;
    }

}