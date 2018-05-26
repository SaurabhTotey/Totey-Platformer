import 'dart:html';
import 'Game.dart';
import 'MovableEntity.dart';

/**
 * The class that represents the main player of the game
 */
class Player extends MovableEntity {

    ImageElement standingSprite = new ImageElement();
    ImageElement jumpingSprite = new ImageElement();
    ImageElement fallingSprites = new ImageElement();
    List<ImageElement> rightSprites = [new ImageElement(), new ImageElement()];
    List<ImageElement> leftSprites = [new ImageElement(), new ImageElement()];

    /**
     * Makes a player given its starting position; players are always 50 wide and 100 tall
     */
    Player(int x, int y) : super(x, y, 50, 100) {
        this.standingSprite.src = "res/playerSprites/standing.png";
        this.jumpingSprite.src = "res/playerSprites/jumping.png";
        this.fallingSprites.src = "res/playerSprites/falling.png";
        for (int i = 0; i < 2; i++) {
            this.rightSprites[i].src = "res/playerSprites/right${i + 1}.png";
            this.leftSprites[i].src = "res/playerSprites/left${i + 1}.png";
        }
        this.sprite = this.standingSprite;
    }

    /**
     * Players stop their horizontal velocity every turn
     */
    void act(Game game) {
        if (this.velocityY < 0) {
            this.sprite = this.jumpingSprite;
        } else if (this.velocityY > 0 && !this.isGrounded) {
            this.sprite = this.fallingSprites;
        } else if (this.velocityX > 0) {
            this.sprite = this.rightSprites.firstWhere((ImageElement img) => this.sprite != img);
        } else if (this.velocityX < 0) {
            this.sprite = this.leftSprites.firstWhere((ImageElement img) => this.sprite != img);
        } else {
            this.sprite = this.standingSprite;
        }
        if (this.velocityY != 0) {
            this.isGrounded = false;
        }
        super.act(game);
        if (this.velocityX > 0) {
            this.velocityX -= 10.0;
            if (this.velocityX < 0) {
                this.velocityX = 0.0;
            }
        } else if (this.velocityX < 0) {
            this.velocityX += 10.0;
            if (this.velocityX > 0) {
                this.velocityX = 0.0;
            }
        }
    }

}