// ignore_for_file: non_constant_identifier_names, unnecessary_this
//An object of this class represent s a single Cell in a grid ecosystem for a singular Cellular automaton
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_automata/util/custom_exceptions.dart';

class Cell {
  bool newState = false; //Changed state for a cell after
  //generation calculation, default value is false(dead)
  bool state =
      false; //current state of a cell within the current generation. Default state is false(dead).
  final Point position;
  //standard cell constructor
  Cell({required this.position, this.state = false, this.newState = false});
  //This function returns all 8 adjacent cells to a single cell.
  List<Cell> getAdjacentCells(List<List<Cell>> parent_grid) {
    List<Cell> cells = [];
    int xc = this.position.x.toInt();
    int yc = this.position.y.toInt();
    int xM = parent_grid.length - 1; //maximum x value  for given parent
    int yM = parent_grid[0].length - 1; //maximum y value
    Point top = Point(xc - 1, yc); //cell directly above
    Point bottom = Point(xc + 1, yc); //cell directly below
    Point right = Point(xc, yc + 1); //cell directly to the right
    Point left = Point(xc, yc - 1); //cell directly to the left
    Point top_right = Point(xc - 1, yc + 1); //top-right cell
    Point top_left = Point(xc - 1, yc - 1); //top-left cell
    Point bottom_right = Point(xc + 1, yc + 1); //bottom-right cell
    Point bottom_left = Point(xc + 1, yc - 1); //bottom-left cell
    List<Point> points = [
      top,
      right,
      bottom,
      left,
      top_right,
      top_left,
      bottom_right,
      bottom_left
    ];
    //List of cells which are expected to exist. It is possible that the cells DO NOT EXIST, in which case
    //co-ordinates will be corrected, and added to the array even still.
//used to determine which Points are redundant
    for (Point test_point in points) {
      Cell c;
      try {
        c = parent_grid[test_point.x.toInt()][test_point.y.toInt()];
      } catch (exception) {
        Point corrected = correctCoords(test_point, parent_grid);
        c = parent_grid[corrected.x.toInt()][corrected.y.toInt()];
      }
      cells.add(c);
    }
    return cells;
  }

  //This function corrects the co-ordinates of a point outside the grid by switching it to a wrap-around
  //position.
  static Point correctCoords(Point p, List<List<Cell>> grid) {
    int x = p.x.toInt();
    int y = p.y.toInt();
    int max_x = grid.length - 1;
    int max_y = grid[0].length - 1;
    if (x < 0) {
      x = max_x;
    } else if (x > max_x) {
      x = 0;
    }
    if (y < 0) {
      y = max_y;
    } else if (y > max_y) {
      y = 0;
    }
    Point return_val = Point(x, y);
    return return_val;
  }

  //This function checks if a point p is located within a certain range, and is valid
  //for a parent grid with set dimensions.
  static bool isPointValid(Point p, int max_x, int max_y) {
    if (((p.x < 0) || (p.y < 0)) || ((p.x > max_x) || (p.y > max_y))) {
      return false;
    }
    return true;
  }

  //Sets the state of a given Cell
  void setState(bool fresh_state) {
    state = fresh_state;
  }

  //This caches the new state of the cell, generally to update to the next generation
  void cacheState(bool fresh_state) {
    newState = fresh_state;
  }

  //Updates the state of the cell to the next generation
  void updateState() {
    state = newState;
  }

  //Method for testing
  String getCellData() {
    String state = (this.state) ? "alive" : "dead";
    String pos = "${this.position.x}, ${this.position.y}";
    return "The cell at $pos is currently $state";
  }

//checks if this cell has the same data as the other cell passed.
  bool equals(Cell c) {
    return getCellData() == (c.getCellData());
  }

//counts how many cells are alive in a particular list of cells.
  int countAliveIn(List<Cell> list) {
    int alive = 0;
    for (Cell c in list) {
      if (c.state) {
        ++alive;
      }
    }
    return alive;
  }

  //counts number of cells dead in a particular list
  int countDeadIn(List<Cell> cells) {
    int alive = countAliveIn(cells);
    return (cells.length) - alive;
  }

//count cells which are currently in alive state for a grid ecosystem
  static int countAlive(List<List<Cell>> grid) {
    int alive = 0;
    for (int i = 0; i < grid.length; ++i) {
      for (int j = 0; j < grid[0].length; ++j) {
        Cell c = grid[i][j];
        if (c.state) {
          ++alive;
        }
      }
    }
    return alive;
  }

  //count cells which are currently in dead state with reference to a particular grid system
  static int countDead(List<List<Cell>> grid) {
    int alive = countAlive(grid);
    int total = grid.length * (grid[0].length);
    int result = total - alive;
    return result;
  }

  static void refreshGrid(List<List<Cell>> grid) {
    for (int i = 0; i < grid.length; ++i) {
      for (int j = 0; j < grid[0].length; ++j) {
        Cell c = grid[i][j];
        c.updateState();
      }
    }
  }

  //Revamps the board, updating the states of all cells by substituting current state with cached
  //state and setting cached states to defaults in preparation for the next generation.
  //Parameter definitions:
  //parent_grid refers to the grid which hosts
  static bool generationUpdate(List<List<Cell>> parent_grid, final int LB,
      final int UB, int ressurection) {
    bool changed = false;

    for (int i = 0; i < parent_grid.length; ++i) {
      for (int j = 0; j < parent_grid[0].length; ++j) {
        Cell current = parent_grid[i][j]; //current cell being examined
        current.calcStateUpdateFor(parent_grid, LB, UB, ressurection);
        if (current.state != current.newState) {
          changed = true;
        }
      }
    }
    refreshGrid(parent_grid);
    //proceeds to update states with cached values
    return changed;
  }

  //Calculates the state of a cell in the grid and updates cached state.
  //returns new state
  void calcStateUpdateFor(
      List<List<Cell>> parent, int lower_bound, int upper_bound, int ress) {
    bool new_state = this.state;

    List<Cell> cells = this.getAdjacentCells(parent);
    int aliveR = Cell.countAlive(parent);
    int deadR = cells.length - aliveR;
    if ((aliveR < lower_bound) || (aliveR > upper_bound)) {
      new_state = false;
    } else if (aliveR == ress) {
      new_state = true;
    }
    this.newState = new_state;
  }

  //Generates a self-sustaining biome of cellular automata, all cells are dead by default, certain number of cells
  //can be specified to be alive before automata is activated by user.
  List<List<Cell>> generateBiome({int? alive, required int x, required int y}) {
    alive = alive ?? 0;
    int total_size = x * y;
    if (alive > total_size) {
      throw MatrixOutOfBoundsException(
          message:
              "Requested units:${alive} \n Total biome size:${total_size} \n Request Denied.");
    }
    List<Cell> cell_list = List.empty(growable: true);
    List<List<Cell>> grid = List.generate(
        x,
        (i) => List.generate(y, (j) {
              Cell c = Cell(position: Point(i, j));
              if (alive != 0) {
                cell_list.add(c);
              }
              return c;
            }));
    //code for randomly picking live cells
    //optimized performance method possible.
    int counter = 0;
    while (counter < alive) {
      Random r = Random();
      for (int i = 0; i < cell_list.length && counter < alive; ++i) {
        num probability = r.nextDouble();
        if (probability > 0.45) {
          Cell c = cell_list[i];
          c.state = true;
          cell_list.remove(c);
          ++counter;
        }
      }
    }
    return grid;
  }

// Generates a random set of points to be set to live position by creating a list of all indices and dynamicaally selecting and shortening List.
  List<Point> generateRandom(List<List<Cell>> parent_grid, int alivec) {
    int total = parent_grid.length * parent_grid[0].length;
    if (alivec > total) {
      throw MatrixOutOfBoundsException(
        message:
            "Requested live cells exceed total board  capacity\nRequest Denied!",
      );
    }
    List<Point> available_points = List.empty();
    int alive = 0;
    for (int i = 0; i < parent_grid.length; i++) {
      for (int j = 0; j < parent_grid[0].length; ++j) {
        available_points.add(Point(i, j));
        Cell cell = parent_grid[i][j];
        if (cell.state) {
          ++alive;
        }
      }
    }

    Random rng = Random();
    for (; alive < alivec; ++alive) {
      int index = rng.nextInt(available_points.length);
      Point req = available_points[index];
      parent_grid[req.x.toInt()][req.y.toInt()].state = true;
      available_points.removeAt(index);
    }
  }
}
