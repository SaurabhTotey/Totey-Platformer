import 'dart:html';
import 'Game.dart';
import 'MovableEntity.dart';

/**
 * The class that represents the main player of the game
 */
class Player extends MovableEntity {

    //The maximum amount of lives the player can have at any given point
    int maxLives = 3;
    //Player's current amount of lives
    int lives = 2;
    //Location of the player's last checkpoint: if the player were to lose a life, they would come back to this position
    List<int> lastCheckPoint;
    //How many coins the player has
    int coins = 0;

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
        this.lastCheckPoint = [x, y];
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
        if (this.x < 0) {
            this.x = 0;
        }
        if (this.x + this.w > game.level.width) {
            this.x = game.level.width - this.w;
        }
        if (this.y < 0) {
            this.y = 0;
        }
    }

    /**
     * What happens when the player loses a life
     */
    void loseLife() {
        this.lives--;
        if (this.lives <= 0) {
            return;
        }
        this.x = lastCheckPoint[0];
        this.y = lastCheckPoint[1];
        this.velocityX = 0.0;
        this.velocityY = 0.0;
    }

}