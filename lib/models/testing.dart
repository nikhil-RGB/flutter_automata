import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_automata/models/Cell.dart';
import 'package:logger/logger.dart';

class testing {
  static Future<void> simulateRandomAutomaton(
      {required int rows, required int columns, required int alive}) async {
    List<List<Cell>> grid =
        Cell.generateGrid(Point(rows, columns)); //control grid
    Cell.setRandomLive(grid,
        alive); //parent grid instantiated,20 random cells(out of 63) set to alive
    Cell.printGrid(grid);
    //simulate Automaton
    for (int gen = 0; Cell.generationUpdate(grid, 2, 5, 3); ++gen) {
      Cell.printGrid(grid);
      await Future.delayed(const Duration(seconds: 1), () {
        debugPrint("Generation Update");
      });
    }
    debugPrint("Automaton ended");
  }

  static void runMethodBenchmark(List<List<Cell>> grid, int x, int y) {
    //test 1:getAdjacentCells()
    Logger logger = Logger();
    logger.wtf(
        "The grid has ${grid.length} rows and ${grid[0].length} columns = ${grid.length * grid[0].length}");
    logger.w("Checkout at psoition $x , $y");
    List<Cell> cells = grid[x][y].getAdjacentCells(grid);
    for (Cell c in cells) {
      logger.i(c.getCellData());
    }
  }
}
