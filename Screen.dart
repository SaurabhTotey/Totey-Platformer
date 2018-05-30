import 'dart:html';
import 'dart:math';
import 'Drawable.dart';
import 'Game.dart';

/**
 * The class that handles the games graphics and drawing to the canvas
 */
class Screen {

    //The canvas that serves as the actual screen to draw on
    CanvasElement screen;
    //The object that actually draws on the canvas
    CanvasRenderingContext2D renderer;
    //The aspect ratio for the game
    final aspectRatio = [16, 9];
    //The framerate or how often the canvas updates
    final framesPerSecond = 60;
    //The game that the screen will be drawing
    Game game;
    //Sprite for showing number of lives
    ImageElement livesSprite = new ImageElement();
    //Sprite for showing number of coins
    ImageElement coinsSprite = new ImageElement();

    /**
     * Constructor for a screen
     * Initializes the renderer and sets the scaling for the screen to match the window
     */
    Screen(this.game) {
        this.screen = new CanvasElement();
        this.renderer = this.screen.context2D;
        //Adds the screen to the page
        querySelector("body").append(this.screen);
        //On window resize, makes sure the canvas size changes to max size will keeping aspect ratio
        void resizeProc ([Event resizeEvent = null]) {
            if (window.innerWidth / aspectRatio[0] < window.innerHeight / aspectRatio[1]) {
                this.screen.width = window.innerWidth;
                this.screen.height = (window.innerWidth * aspectRatio[1] / aspectRatio[0]).round();
            } else {
                this.screen.height = window.innerHeight;
                this.screen.width = (window.innerHeight * aspectRatio[0] / aspectRatio[1]).round();
            }
            this.update();
        };
        resizeProc();
        window.onResize.listen(resizeProc);
        this.livesSprite.src = "res/heart.png";
        this.coinsSprite.src = "res/coin.png";
    }

    /**
     * Updates the screen and redraws it
     */
    void update() {
        //Clears screen
        this.renderer.fillStyle = "black";
        this.renderer.fillRect(0, 0, this.screen.width, this.screen.height);
        //Gets the game's logical viewport
        var logicalX = this.game.player.center()[0] - this.game.width / 2;
        var logicalY = this.game.player.center()[1] - this.game.height / 2;
        var maxPossibleLogicalX = this.game.level.width - this.game.width;
        var maxPossibleLogicalY = this.game.level.height - this.game.height;
        if (logicalX < 0) {
            logicalX = 0;
        }
        if (logicalX + this.game.width > this.game.level.width) {
            logicalX = maxPossibleLogicalX;
        }
        if (logicalY < 0) {
            logicalY = 0;
        }
        if (logicalY + this.game.height > this.game.level.height) {
            logicalY = maxPossibleLogicalY;
        }
        //Gets a conversion between logical coordinates and screen coordinates
        double stretchX = this.screen.width / this.game.width;
        double stretchY = this.screen.height / this.game.height;
        //Draws the game's background with parallax
        if (this.game.level.background.sprite.src.isNotEmpty) {
            int bgWidth = this.game.level.background.sprite.width;
            int bgHeight = this.game.level.background.sprite.height;
            this.renderer.drawImageToRect(
                this.game.level.background.sprite,
                new Rectangle(0, 0, this.screen.width, this.screen.height),
                sourceRect: new Rectangle(
                    logicalX / maxPossibleLogicalX * (1 - this.game.level.horizontalVisibility) * bgWidth,
                    logicalY / maxPossibleLogicalY * (1 - this.game.level.verticalVisibility) * bgHeight,
                    this.game.level.horizontalVisibility * bgWidth,
                    this.game.level.verticalVisibility * bgHeight
                )
            );
        }
        //Draws all of game objects
        List<Drawable> drawables = new List();
        drawables.addAll(this.game.level.drawables);
        drawables.addAll(this.game.entities);
        drawables.add(this.game.player);
        for (final obj in drawables) {
            if (obj.x + obj.w < logicalX || obj.y + obj.h < logicalY || obj.x > logicalX + this.game.width || obj.y > logicalY + this.game.height) {
                continue;
            }
            this.renderer.fillStyle = obj.bg.toString();
            this.renderer.fillRect((obj.x - logicalX) * stretchX, (obj.y - logicalY) * stretchY, obj.w * stretchX, obj.h * stretchY);
            if (obj.sprite.src.isNotEmpty) {
                this.renderer.drawImageToRect(obj.sprite, new Rectangle((obj.x - logicalX) * stretchX, (obj.y - logicalY) * stretchY, obj.w * stretchX, obj.h * stretchY));
            }
        }
        //Draws player lives and coins
        final guiSize = 0.05 * this.screen.width;
        this.renderer.fillStyle = "red";
        this.renderer.font = "${0.05 * sqrt(pow(this.screen.width, 2) + pow(this.screen.height, 2))}px Arial";
        this.renderer.fillText("${this.game.player.lives}x", this.screen.width - 2 * guiSize, guiSize, guiSize);
        this.renderer.drawImageToRect(this.livesSprite, new Rectangle(this.screen.width - guiSize, 0, guiSize, guiSize));
        this.renderer.fillStyle = "yellow";
        this.renderer.fillText("${this.game.player.coins}x", 0, guiSize, guiSize);
        this.renderer.drawImageToRect(this.coinsSprite, new Rectangle(guiSize, 0, guiSize, guiSize));
    }

}