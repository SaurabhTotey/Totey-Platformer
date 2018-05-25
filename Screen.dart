import 'dart:html';

/**
 * The class that handles the games graphics and drawing to the canvas
 */
class Screen {

    //The canvas that serves as the actual screen to draw on
    CanvasElement screen;
    //The object that actually draws on the canvas
    CanvasRenderingContext2D renderer;
    //The aspect ratio for the game
    List<int> aspectRatio = [16, 9];

    /**
     * Constructor for a screen
     * Initializes the renderer and sets the scaling for the screen to match the window
     */
    Screen() {
        this.screen = new CanvasElement();
        this.renderer = this.screen.getContext('2d');
        //Adds the screen to the page
        querySelector("body").append(this.screen);
        //On window resize, makes sure the canvas size changes to max size will keeping aspect ratio
        void resizeProc ([Event resizeEvent = null]) {
            if (window.innerWidth / aspectRatio[0] < window.innerHeight / aspectRatio[1]) {
                this.screen.width = window.innerWidth;
                this.screen.height = window.innerWidth * aspectRatio[1] / aspectRatio[0];
            } else {
                this.screen.height = window.innerHeight;
                this.screen.width = window.innerHeight * aspectRatio[0] / aspectRatio[1];
            }
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