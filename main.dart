import 'dart:async';
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
    final crapTestLevel = new Level(startingPosition: [0, 0], entities: [new SolidPlatform(0, 800, 800, 100), new EndBlock(900, 750)], drawables: [new Drawable(0, 0, 1600, 900, bg: const Color(135, 206, 250))]);

    Game game = new Game(crapTestLevel);
    Screen screen = new Screen(game);

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