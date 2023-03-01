import 'package:flutter/material.dart';
import 'package:flutter_automata/models/testing.dart';
import 'package:flutter_automata/pages/AutomatonPage.dart';

import 'models/Cell.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //Root of your application.
  @override
  Widget build(BuildContext context) {
    List<List<Cell>> grid = Cell.generateGrid(9, 7);
    Cell.setRandomLive(grid, 21);
    testing.runMethodBenchmark(grid, 0, 0);
    return MaterialApp(
      title: 'Cellular Automaton',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AutomatonPage(grid: grid),
    );
  }
}
