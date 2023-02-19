import 'package:flutter_automata/models/Cell.dart';

class testing {
  static Future<void> simulateRandomAutomaton(
      {required int rows, required int columns, required int alive}) async {
    List<List<Cell>> grid = Cell.generateGrid(rows, columns); //control grid
    Cell.setRandomLive(grid,
        alive); //parent grid instantiated,20 random cells(out of 63) set to alive
    Cell.printGrid(grid);
    //simulate Automaton
    for (int gen = 0; Cell.generationUpdate(grid, 2, 5, 3); ++gen) {
      Cell.printGrid(grid);
      await Future.delayed(const Duration(seconds: 1), () {
        print("Generation Update");
      });
    }
    print("Automaton ended");
  }
}
