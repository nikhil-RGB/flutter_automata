// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Cell.dart';

class AutomatonPage extends StatefulWidget {
  @override
  State<AutomatonPage> createState() => _AutomatonPageState();
  static bool running = true;
  int ub;
  int lb;
  int ress;
  final List<List<Cell>> grid; //grid which will be used to build the board
  AutomatonPage(
      {super.key,
      required this.grid,
      required this.ub,
      required this.lb,
      required this.ress});
}

class _AutomatonPageState extends State<AutomatonPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text("Cellular automata"),
        ),
        body: CellGrid(
          grid: widget.grid,
          initPage: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (AutomatonPage.running) {
              setState(() {
                AutomatonPage.running = Cell.generationUpdate(
                    widget.grid, widget.lb, widget.ub, widget.ress);
              });
              if (!AutomatonPage.running) {
                await openInfoDialog(
                    context: context,
                    details:
                        "The Grid system has either stabilized or been force killed.\nNo further growth possible!",
                    title: "Automaton Stabilized");
              }
            } else {
              await openInfoDialog(
                  context: context,
                  details:
                      "The Grid system has either stabilized or been force killed.\nNo further growth possible!",
                  title: "Grid Biome Disabled");
            }
          },
          backgroundColor: Colors.cyan,
          child: const Icon(Icons.play_arrow_rounded),
        ),
      ),
    );
  }

  Future openInfoDialog(
          {String? title,
          required String details,
          required BuildContext context}) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              title ?? "Info:",
              style: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            content: Text(
              details,
              style: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Ok", style: GoogleFonts.dmSans()),
              ),
            ],
            backgroundColor: const Color(0XFF004246),
          );
        },
      );
}
