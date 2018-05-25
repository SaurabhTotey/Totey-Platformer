import 'MovableEntity.dart';

/**
 * The class that represents the main player of the game
 */
class Player extends MovableEntity {

    /**
     * Makes a player given its starting position; players are always 50 wide and 100 tall
     */
    Player(int x, int y) : super(x, y, 50, 100);

}