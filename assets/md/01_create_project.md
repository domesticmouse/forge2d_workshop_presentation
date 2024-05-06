## Create your Flutter project


1. On a command line, create a Flutter project:

```console
$ flutter create --empty forge2d_game 
Creating project forge2d_game...
Resolving dependencies in forge2d_game... (4.7s)
Got dependencies in forge2d_game.
Wrote 128 files.

All done!
You can find general documentation for Flutter at: https://docs.flutter.dev/
Detailed API documentation is available at: https://api.flutter.dev/
If you prefer video documentation, consider: https://www.youtube.com/c/flutterdev

In order to run your empty application, type:

  $ cd forge2d_game
  $ flutter run

Your empty application code is in forge2d_game/lib/main.dart.
```

2. Modify the project's dependencies to add Flame and Forge2D:

```console
$ cd forge2d_game
$ flutter pub add characters flame flame_forge2d xml 
Resolving dependencies...
  characters 1.3.0 (from transitive dependency to direct dependency)
+ flame 1.17.0
+ flame_forge2d 0.18.0
+ forge2d 0.13.0
  leak_tracker 10.0.0 (10.0.5 available)
  leak_tracker_flutter_testing 2.0.1 (3.0.5 available)
  leak_tracker_testing 2.0.1 (3.0.1 available)
  material_color_utilities 0.8.0 (0.11.1 available)
  meta 1.11.0 (1.14.0 available)
+ ordered_set 5.0.2
+ petitparser 6.0.2
  test_api 0.6.1 (0.7.0 available)
  vm_service 13.0.0 (14.2.0 available)
+ xml 6.5.0
Changed 7 dependencies!
7 packages have newer versions incompatible with dependency constraints.
Try `flutter pub outdated` for more information.
```