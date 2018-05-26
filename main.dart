import 'dart:async';
import 'dart:html' hide Screen;
import 'Drawable.dart';
import 'EndBlock.dart';
import 'Game.dart';
import 'Level.dart';
import 'Screen.dart';
import 'SolidPlatform.dart';

/**
 * Entry point of the program
 */
void main() {
    //Temporary crappy level for testing purposes
    final crapTestLevel = new Level(width: 3200, height: 1800, startingPosition: [0, 0], entities: [new SolidPlatform(0, 1700, 800, 100), new SolidPlatform(800, 1600, 800, 100), new SolidPlatform(1600, 1500, 800, 100), new SolidPlatform(2400, 1400, 400, 100), new EndBlock(3150, 1200)], drawables: [new Drawable(0, 0, 3200, 1800, bg: const Color(135, 206, 250))]);

    //Creates the objects that will represent the logic and graphics respectively
    Game game = new Game(crapTestLevel);
    Screen screen = new Screen(game);

    //Binds keys to game functions
    window.onKeyDown.listen((KeyboardEvent event) {
        switch (event.keyCode) {
            case KeyCode.W: {
                if (game.player.velocityY == 0) {
                    game.player.velocityY = -5.0;
                }
                break;
            }
            case KeyCode.A: {
                game.player.velocityX = -15.0;
                break;
            }
            case KeyCode.S: {
                break;
            }
            case KeyCode.D: {
                game.player.velocityX = 15.0;
                break;
            }
            default: break;
        }
    });

    //Times game updates to happen periodically
    new Timer.periodic(new Duration(milliseconds: (1000 / game.ticksPerSecond).round()), (Timer t) {
        game.update();
        if (game.isFinished) {
            t.cancel();
        }
    });

    //Times screen updates to happen periodically
    new Timer.periodic(new Duration(milliseconds: (1000 / screen.framesPerSecond).round()), (Timer t) {
        screen.update();
        if (game.isFinished) {
            t.cancel();
        }
    });
}