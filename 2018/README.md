# 2018 Godot 3 demos

All of these demos work in Godot 3.

## Finite State Machine - 04/24/2018

Sample source code from the [Godot 3 course](https://gumroad.com/l/godot-tutorial-make-professional-2d-games) on Gumroad. It shows how to implement the State pattern in GDScript, including Hierarchical States and a pushdown automaton.

States are common in games. You can use the pattern to:

1. Separate each behavior and transitions between behaviors, thus make scripts shorter and easier to manage
2. Respect the Single Responsibility Principle. Each State object represents one action
3. Improve your code's structure. Look at the scene tree and FileSystem tab: without looking at the code, you'll know what the Player can or cannot do.

You can read more about States in the excellent [ Game Programming Patterns ](http://gameprogrammingpatterns.com/state.html) ebook.


## Astar pathfinding - 03/30/2018

I wrote this project as an [ official demo ](https://github.com/godotengine/godot-demo-projects/pull/236) to help people get started with the engine. Godot's AStar pathfinding class is both flexible and powerful, but it can be a little daunting at first. You'll find a commented script in the project, and a character that smoothly follows paths using the follow steering behavior.

You'll also find an updated [ Navigation2D demo ](https://github.com/godotengine/godot-demo-projects/tree/master/2d/navigation) in the official sources to go along with it.
