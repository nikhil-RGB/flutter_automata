// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellButton.dart';

import 'models/Cell.dart';

class CellGrid extends StatefulWidget {
  double spacing = 5.0;

  Color dead;
  Color live;
  bool
      initPage; //true if this cell grid is used for initializing the automaton, false otherwise.
  List<List<Cell>> grid; //Grid of Cells used for reference
  List<List<Widget>> buttons = []; //list of buttons
  CellGrid(
      {super.key,
      required this.grid,
      this.live = Colors.green,
      this.dead = Colors.red,
      required this.initPage}) {
    int columns = grid[0].length;
    while (columns > 0 && spacing > 0) {
      spacing = spacing - 0.5;
      columns = columns - 10;
    }
    spacing = (spacing <= 0) ? 0.02 : spacing;
  }

  @override
  State<CellGrid> createState() => _CellGridState();
}

class _CellGridState extends State<CellGrid> {
  @override
  Widget build(BuildContext context) {
    widget.buttons.clear();
    for (int i = 0; i < widget.grid.length; ++i) {
      widget.buttons.add(List.empty(growable: true));
      for (int j = 0; j < widget.grid[0].length; ++j) {
        widget.buttons[i].add(generateGridCell(widget.grid[i][j]));
      }
    }
    return InteractiveViewer(
      maxScale: 15.0, //increased max scale
      minScale: 1.0, //do not want users to minimize the grid, unrequired.
      child: Center(
        child: Container(
          // ignore: prefer_const_constructors

          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(7),
            color: const Color(0x1AD9D9D9),
          ),
          margin:
              const EdgeInsets.only(top: 5, bottom: 10, left: 10, right: 10),
          padding: const EdgeInsets.only(
            right: 12,
            left: 12,
            top: 20,
            bottom: 20,
          ),
          child: Center(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification overscroll) {
                overscroll.disallowIndicator();
                return true;
              },
              child: GridView.count(
                shrinkWrap: true,
                padding: const EdgeInsets.all(0),
                crossAxisCount: widget.grid[0].length,
                crossAxisSpacing: widget.spacing,
                mainAxisSpacing: widget.spacing,
                children: compress(widget.buttons),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget generateGridCell(Cell ref) {
    return widget.initPage
        ? CellButton(
            cell: ref,
          )
        : Container(
            height: 20,
            decoration: BoxDecoration(
              color: ref.state ? widget.live : widget.dead,
            ),
          );
  }

  // converts a double dimension list to single dimension and accesses a particular cell using a single dimension index.
  // Cell singleDimensionAccess(int sda, List<List<Cell>> grid) {
  //   List<Cell> cells = List.empty(growable: true);
  //   for (int i = 0; i < grid.length; ++i) {
  //     for (int j = 0; j < grid[0].length; ++j) {
  //       cells.add(grid[i][j]);
  //     }
  //   }
  //   return cells[sda];
  // }

  //switches the grid being used for reference whilst also updating the UI with the same.
  void switchContext(List<List<Cell>> obj) {
    setState(() {
      widget.grid = obj;
    });
  }

  List<Widget> compress(List<List<Widget>> grid) {
    List<Widget> compressed = List.empty(growable: true);
    for (int i = 0; i < grid.length; ++i) {
      for (int j = 0; j < grid[0].length; ++j) {
        compressed.add(grid[i][j]);
      }
    }
    return compressed;
  }
}
