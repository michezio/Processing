# Pong2

My reinterpretation of the classic arcade game _Pong_ based on the tutorial from Daniel Shiffman.
It was one of my first works with Processing and Java language in general so it's poorly written, not commented and still buggy. Maybe someday I'll make an updated version.

## How it works

The objective for each player is to score 10 points before the opponent. The other gets a point when a player fails to return the ball.
Unlike classic Pong, you can move the paddle in 4 directions: use WASD for left-side player and IJKL for right-side player. The ball reflects from the paddle at a varying angle based on the distance from the center of the paddle and the point of the paddle it hit. Also if the ball is hit while the paddle is moving vertically its trajectory curves too. If hit when the paddle moves towards the ball, its speed increases, when moving away the speed decreases.

## Known bugs

* You can hit a slow ball and then move past it. The ball wont check contact again since its direction has already changed. This is not a game-breaker but still very poor looking, i know.
* You can sometimes hit a ball even if it has already gone past your paddle if you move backward. This can be annoying sometimes, especially for your opponent.

### License
This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
