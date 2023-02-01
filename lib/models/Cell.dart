// ignore_for_file: non_constant_identifier_names

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
  List<Cell> getAdjacentCells(List<dynamic> parent_grid) {
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
    //List of cells which are expected to exist. It is possible that the cells DO NOT EXIST
    int index = 0; //used to determine which Points are redundant
    for (Point test_point in points) {
      try {
        Cell c = parent_grid[test_point.x.toInt()][test_point.y.toInt()];
        cells.add(c);
      } catch (exception) {
        points.removeAt(index); //removes redundant index
      }
    }
    return cells;
  }
}
