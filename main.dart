import 'dart:async';
import 'dart:html' hide Screen;
import 'CheckPointGrave.dart';
import 'Drawable.dart';
import 'EndBlock.dart';
import 'Game.dart';
import 'ItemBlock.dart';
import 'Level.dart';
import 'Screen.dart';
import 'SolidPlatform.dart';

/**
 * Entry point of the program
 */
void main() {
    //Temporary crappy level for testing purposes
    final crapTestLevel = new Level(width: 3200, height: 1200, startingPosition: [0, 1000], entities: [new SolidPlatform(0, 1100, 800, 50), new SolidPlatform(800, 1000, 800, 50), new SolidPlatform(1600, 900, 800, 50), new CheckPointGrave(1975, 825), new SolidPlatform(2400, 800, 400, 50), new EndBlock(3100, 600), new ItemBlock(375, 900), new ItemBlock(1175, 800, new CheckPointGrave(1175, 725))], background: new Drawable(0, 0, 3200, 1200, spriteSrc: "res/backgrounds/pineHills.png"));

    //Creates the objects that will represent the logic and graphics respectively
    Game game = new Game(crapTestLevel);
    Screen screen = new Screen(game);

    //Binds keys to game functions
    List<int> pressedKeys = [];
    window.onKeyDown.listen((KeyEvent event) {
        if (!pressedKeys.contains(event.keyCode)) {
            pressedKeys.add(event.keyCode);
        }
    });
    window.onKeyUp.listen((KeyEvent event) {
        pressedKeys.removeWhere((code) => code == event.keyCode);
    });
    //Times key handling to happen periodically
    new Timer.periodic(new Duration(milliseconds: (1000 / 20).round()), (Timer t) {
        for (final keyCode in pressedKeys) {
            switch (keyCode) {
                case KeyCode.W: {
                    if (game.player.isGrounded) {
                        game.player.velocityY = -20.0;
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