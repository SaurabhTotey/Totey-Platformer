import 'dart:html';
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
    //The game that the screen will be drawing
    Game game;

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
    }

    /**
     * Updates the screen and redraws it
     */
    void update() {
        this.renderer.fillStyle = "lightblue";
        this.renderer.fillRect(0, 0, this.screen.width, this.screen.height);
    }

}