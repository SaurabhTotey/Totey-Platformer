import 'Entity.dart';
import 'Level.dart';
import 'Player.dart';

/**
 * The class that handles all of the game logic
 */
class Game {

    //The logical width of the viewport
    final width = 1600;
    //The logical height of the viewport
    final height = 900;
    //How many times the game updates in a second
    final ticksPerSecond = 30;
    //Whether the game is in progress or not
    bool isFinished = false;
    //The current level of the game
    Level level;
    //The player of the game
    Player player;
    //The other entities in the game
    List<Entity> entities;

    /**
     * Constructs a game given a level
     */
    Game(this.level) {
        this.player = new Player(this.level.startingPosition[0], this.level.startingPosition[1]);
        this.entities = new List.from(this.level.entities);
    }

    /**
     * What happens every tick
     * Handles propogating updates to all other entities
     */
    void update() {
        this.player.act(this);
        this.entities.forEach((entity) => entity.act(this));
        if (this.player.y > this.level.height) {
            this.player.loseLife();
        }
        if (this.player.lives <= 0) {
            this.isFinished = true;
        }
    }

}