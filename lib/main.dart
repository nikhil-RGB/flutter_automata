// ignore_for_file: constant_identifier_names
import 'dart:math';

import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_automata/models/testing.dart';
import 'package:flutter_automata/pages/AutomatonPage.dart';
import 'models/Cell.dart';

//constants for standard connways game of life, and for testing
const int lower_bound = 2;
const int upper_bound = 5;
const int ressurection = 3;
const Point dimensions = Point(40, 40);
const int alives = 450;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //Root of your application.
  @override
  Widget build(BuildContext context) {
    List<List<Cell>> grid = Cell.generateGrid(dimensions);
    Cell.setRandomLive(grid, alives);
    // testing.runMethodBenchmark(grid, 0, 0);
    return MaterialApp(
      title: 'Cellular Automaton',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: AutomatonPage(
        grid: grid,
        lb: lower_bound,
        ub: upper_bound,
        ress: ressurection,
      ),
    );
  }
}
