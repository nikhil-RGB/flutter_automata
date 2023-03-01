// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

import 'models/Cell.dart';

class CellGrid extends StatefulWidget {
  List<List<Cell>> grid; // Grid of Cells used for reference
  List<List<ElevatedButton>> buttons = []; //list of buttons
  CellGrid({super.key, required this.grid});

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
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      padding: const EdgeInsets.only(
        right: 12,
        left: 12,
      ),
      child: Center(
        child: GridView.count(
          shrinkWrap: true,
          padding: const EdgeInsets.all(0),
          crossAxisCount: widget.grid[0].length,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          children: compress(widget.buttons),
        ),
      ),
    );
  }

  ElevatedButton generateGridCell(Cell ref) {
    return ElevatedButton(
      onPressed: () {
        //for testing purpose only
        List<Cell> cells = ref.getAdjacentCells(widget.grid);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: (ref.state) ? Colors.green : Colors.red,
      ),
      child: const Text(""),
    );
  }

  //converts a double dimension list to single dimension and accesses a particular cell using a single dimension index.
  Cell singleDimensionAccess(int sda, List<List<Cell>> grid) {
    List<Cell> cells = List.empty(growable: true);
    for (int i = 0; i < grid.length; ++i) {
      for (int j = 0; j < grid[0].length; ++j) {
        cells.add(grid[i][j]);
      }
    }
    return cells[sda];
  }

  //switches the grid being used for reference whilst also updating the UI with the same.
  void switchContext(List<List<Cell>> obj) {
    setState(() {
      //I really like using the this keyword
      // ignore: unnecessary_this
      widget.grid = obj;
    });
  }

  List<ElevatedButton> compress(List<List<ElevatedButton>> grid) {
    List<ElevatedButton> compressed = List.empty(growable: true);
    for (int i = 0; i < grid.length; ++i) {
      for (int j = 0; j < grid[0].length; ++j) {
        compressed.add(grid[i][j]);
      }
    }
    return compressed;
  }
}
