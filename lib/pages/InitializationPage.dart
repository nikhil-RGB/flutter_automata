import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';
import 'package:flutter_automata/pages/AutomatonPage.dart';
import 'package:flutter_automata/util/DialogManager.dart';
import 'package:google_fonts/google_fonts.dart';

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
  BuildContext? ctxt;
  @override
  Widget build(BuildContext context) {
    ctxt = context;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   title: const Text("Initialize your automaton"),
        //   backgroundColor: Colors.black,
        //   foregroundColor: Colors.cyan,
        //   actions: [
        //     generateSpecialMenu(),
        // ],
        // ),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            generateAppBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.15),
            CellGrid(
              grid: widget.grid,
              initPage: true,
            ),
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     AutomatonPage.running = true;
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: ((context) => AutomatonPage(
        //                 grid: Cell.cloneGrid(widget.grid),
        //                 ub: widget.ub,
        //                 lb: widget.lb,
        //                 ress: widget.ress))));
        //   },
        //   backgroundColor: Colors.cyan,
        //   child: const Icon(Icons.fast_forward_outlined),
        // ),
      ),
    );
  }

  Widget generateSpecialMenuButton() {
    return PopupMenuButton<int>(
        color: const Color(0xFF161616),
        itemBuilder: (context) => [
              PopupMenuItem(
                  value: 0,
                  child: Text(
                    "Change pre-defined rules",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 1,
                  child: Text(
                    "Set custom growth rate",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 2,
                  child: Text(
                    "Change Color scheme",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Text(
                    "Randomize Initial configuration.",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 4,
                  child: Text(
                    "Reset Board",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
            ],
        onSelected: (value) async {
          switch (value) {
            case 0:
              {}
              break;
            case 1:
              {}
              break;
            case 2:
              {}
              break;
            case 3:
              {
                int alivec = await DialogManager.openNumericalDialog(
                  max: widget.grid.length * widget.grid[0].length,
                  context: ctxt!,
                  title: "Input minimum number of cells required to be alive",
                );
                if (alivec == -1) {
                  return;
                }
                setState(() async {
                  Cell.setRandomLive(widget.grid, alivec);
                });
              }
              break;
            case 4:
              {
                setState(() {
                  Cell.clearGrid(widget.grid);
                });
              }
              break;
          }
        },
        child: const Icon(
          Icons.menu_rounded,
          color: Colors.cyan,
        ));
  }

  Widget generateAppBar() {
    return Row(
      children: [
        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
        generateSpecialMenuButton(),
        SizedBox(width: MediaQuery.of(context).size.width * 0.45),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan,
              shape: const BeveledRectangleBorder()),
          child: Text(
            "Create Automata",
            style: GoogleFonts.sourceCodePro(),
          ),
          onPressed: () {
            AutomatonPage.running = true;
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: ((context) => AutomatonPage(
                        grid: Cell.cloneGrid(widget.grid),
                        ub: widget.ub,
                        lb: widget.lb,
                        ress: widget.ress))));
          },
        ),
        SizedBox(width: MediaQuery.of(context).size.width * 0.03),
      ],
    );
  }
}
