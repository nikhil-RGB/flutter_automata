// ignore_for_file: non_constant_identifier_names, unnecessary_this
//An object of this class represent s a single Cell in a grid ecosystem for a singular Cellular automaton
import 'dart:math';

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
        cells.add(c);
      } catch (exception) {
        Point corrected = correctCoords(test_point, parent_grid);
        c = parent_grid[corrected.x.toInt()][corrected.y.toInt()];
      }
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

  //Revamps the board, updating the states of all cells by substituting current state with cached
  //state and setting cached states to defaults in preparation for the next generation.
  bool stateUpdate() {
    throw UnimplementedError(); //method unimplemeted, calculates new states, caches fresh states.
    //proceeds to update states with cached values
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
}
