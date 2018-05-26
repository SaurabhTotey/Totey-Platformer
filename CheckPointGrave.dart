import 'dart:html';
import 'Drawable.dart';
import 'Entity.dart';
import 'Game.dart';

/**
 * A class that represents a checkpoint
 * Takes the shape of a grave
 */
class CheckPointGrave extends Entity {

    //The sprite for an activated grave
    static ImageElement activatedSprite = new ImageElement();
    //The sprite for an unactivated grave
    static ImageElement inertSprite = new ImageElement();

    //Where the player will respawn if this grave is their last checkpoint
    List<int> respawnPoint;

    /**
     * Creates a CheckPointGrave given its location
     */
    CheckPointGrave(int x, int y): super(x, y, 50, 75) {
        if (activatedSprite.src.isEmpty) {
            activatedSprite.src = "res/graveSprites/active.png";
            inertSprite.src = "res/graveSprites/inert.png";
        }
        this.sprite = inertSprite;
        this.respawnPoint = [this.x, this.y - 25];
    }

    /**
     * Checks for player collisions: if one exists, sets the player's respawn point to this grave
     */
    void act(Game game) {
        if (game.player.lastCheckPoint == this.respawnPoint) {
            this.sprite = activatedSprite;
        } else {
            this.sprite = inertSprite;
        }
        if (intersect(this, game.player)) {
            game.player.lastCheckPoint = this.respawnPoint;
            this.sprite = activatedSprite;
        }
    }

}