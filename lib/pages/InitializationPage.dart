import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';
import 'package:flutter_automata/pages/AutomatonPage.dart';

import '../models/Cell.dart';

// ignore: must_be_immutable
class InitializationPage extends StatefulWidget {
  @override
  State<InitializationPage> createState() => _InitializationPageState();
  final int x; //Number of rows
  final int y; //Number of columns
  late List<List<Cell>> grid; //Grid of cells
  int ub;
  int lb;
  int ress;
  InitializationPage(this.x, this.y,
      {super.key, required this.ub, required this.lb, required this.ress}) {
    grid = Cell.generateGrid(Point(x, y));
  }
}

class _InitializationPageState extends State<InitializationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Initialize your automaton")),
      body: CellGrid(
        grid: widget.grid,
        initPage: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => AutomatonPage(
                      grid: widget.grid,
                      ub: widget.ub,
                      lb: widget.lb,
                      ress: widget.ress))));
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.fast_forward_outlined),
      ),
    );
  }
}
