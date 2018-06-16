import 'dart:html';
import '../items/Coin.dart';
import '../graphics/Drawable.dart';
import '../core/Entity.dart';
import '../core/Game.dart';
import '../core/MovableEntity.dart';

/**
 * A class that represents a static block that can hold an item
 */
class ItemBlock extends Entity {

    static ImageElement mysteryItemSprite = new ImageElement();
    static ImageElement emptyItemSprite = new ImageElement();

    //What the block has inside of it
    Entity containedItem;

    /**
     * Makes an item block given its position and maybe its contained item
     * Contained item defualts to coin
     */
    ItemBlock(int x, int y, [this.containedItem = null]) : super(x, y, 50, 50) {
        if (mysteryItemSprite.src.isEmpty) {
            mysteryItemSprite.src = "res/questionSquare.png";
            emptyItemSprite.src = "res/depletedBox.png";
        }
        if (this.containedItem == null) {
            this.containedItem = new Coin(this.x, this.y - 25);
        }
        this.sprite = mysteryItemSprite;
    }

    /**
     * The block acts like a solid platform unless hit from below, in which case this will pop out its contained item
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
                if (this.containedItem != null) {
                    game.spawn(this.containedItem);
                    this.containedItem = null;
                    this.sprite = emptyItemSprite;
                }
            }
        }
    }

}