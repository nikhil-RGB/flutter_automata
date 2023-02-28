import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';

import '../models/Cell.dart';

class AutomatonPage extends StatefulWidget {
  @override
  State<AutomatonPage> createState() => _AutomatonPageState();
  final List<List<Cell>> grid; //grid which will be used to build the board
  const AutomatonPage({super.key, required this.grid});
}

class _AutomatonPageState extends State<AutomatonPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cellular automata"),
      ),
      body: CellGrid(
        grid: widget.grid,
      ),
    );
  }
}
