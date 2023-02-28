// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'models/Cell.dart';

class CellGrid extends StatefulWidget {
  final List<List<Cell>> grid; // Grid of Cells used for reference

  const CellGrid({super.key, required this.grid});

  @override
  State<CellGrid> createState() => _CellGridState();
}

class _CellGridState extends State<CellGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: prefer_const_constructors
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: GridView.count(
        crossAxisCount: widget.grid[0].length,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children:
            List.generate(widget.grid.length * widget.grid[0].length, (index) {
          //Come back here for returning CellButton object
          return generateGridCell(singleDimensionAccess(index, widget.grid));
        }),
      ),
    );
  }

  ElevatedButton generateGridCell(Cell ref) {
    return ElevatedButton(
      onPressed: () {},
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
}
