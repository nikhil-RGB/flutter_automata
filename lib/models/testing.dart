import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';
import 'package:flutter_automata/models/Cell.dart';

class testing extends StatefulWidget {
  static bool running = true;
  final List<List<Cell>> grid; //Cellular Automaton grid
  const testing({super.key, required this.grid});

  static Future<void> simulateRandomAutomaton(
      {required int rows, required int columns, required int alive}) async {
    List<List<Cell>> grid = Cell.generateGrid(rows, columns); //control grid
    Cell.setRandomLive(grid,
        alive); //parent grid instantiated,20 random cells(out of 63) set to alive
    Cell.printGrid(grid);
    //simulate Automaton
    for (int gen = 0; Cell.generationUpdate(grid, 2, 5, 3); ++gen) {
      Cell.printGrid(grid);
      await Future.delayed(const Duration(seconds: 1), () {
        debugPrint("Generation Update");
      });
    }
    debugPrint("Automaton ended");
  }

  @override
  State<testing> createState() => _testingState();
}

class _testingState extends State<testing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cellular automata"),
      ),
      body: CellGrid(
        grid: widget.grid,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (testing.running) {
            setState(() {
              testing.running = Cell.generationUpdate(widget.grid, 2, 5, 3);
            });
          }
        },
        backgroundColor: Colors.cyan,
        child: const Icon(Icons.play_arrow_rounded),
      ),
    );
  }
}
