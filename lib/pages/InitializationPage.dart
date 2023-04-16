import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';
import 'package:flutter_automata/pages/AboutUs.dart';
import 'package:flutter_automata/pages/AutomatonPage.dart';
import 'package:flutter_automata/pages/EncrypterPage.dart';
import 'package:flutter_automata/util/DialogManager.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/Cell.dart';

// ignore: must_be_immutable
class InitializationPage extends StatefulWidget {
  @override
  State<InitializationPage> createState() => _InitializationPageState();
  final int x; //Number of rows
  final int y; //Number of columns
  bool beautify = false;
  late List<List<Cell>> grid; //Grid of cells
  int ub;
  int lb;
  int ress;
  int time = 200;
  static int minTime = 10;

  InitializationPage(this.x, this.y,
      {super.key, required this.ub, required this.lb, required this.ress}) {
    grid = Cell.generateGrid(Point(x, y));
  }
}

class _InitializationPageState extends State<InitializationPage> {
  BuildContext? ctxt;
  @override
  void initState() {
    widget.time = calculateOptimalTimeFor(
        cols: widget.grid[0].length, rows: widget.grid.length);
    super.initState();
  }

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
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            toolsSection(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            Expanded(
              child: CellGrid(
                pretty: false,
                grid: widget.grid,
                initPage: true,
                // live: Colors.cyan,
                // dead: Colors.grey,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
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
              // PopupMenuItem(
              //     value: 2,
              //     child: Text(
              //       "Change Color scheme",
              //       style: GoogleFonts.sourceCodePro(color: Colors.white),
              //     )),
              PopupMenuItem(
                  value: 4,
                  child: Text(
                    "Generate Encryption Keys[EXPERIMENTAL]",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 5,
                  child: Text(
                    "About us",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
              PopupMenuItem(
                  value: 3,
                  child: Text(
                    "Exit Interface",
                    style: GoogleFonts.sourceCodePro(color: Colors.white),
                  )),
            ],
        onSelected: (value) async {
          switch (value) {
            case 0:
              {
                // DialogManager.openInfoDialog(
                //     details: "Not implemented yet!", context: context);
                List rules = await DialogManager.openRuleChangeDialog(
                    context: context,
                    prev_lb: widget.lb,
                    prev_ub: widget.ub,
                    prev_ress: widget.ress);
                if (rules.isEmpty) {
                  return;
                }
                widget.lb = rules[0];
                widget.ub = rules[1];
                widget.ress = rules[2];
              }
              break;
            case 1:
              {
                // DialogManager.openInfoDialog(
                //     details: "Not implemented yet!", context: context);
                widget.time = await DialogManager.openTimeDialog(
                  context: context,
                  min: InitializationPage.minTime,
                  current: widget.time,
                );
              }
              break;
            // case 2:
            //   {
            //     DialogManager.openInfoDialog(
            //         details: "Not implemented yet!", context: context);
            //   }
            //   break;
            case 3:
              {
                Phoenix.rebirth(context);
              }
              break;
            case 4:
              {
                EncrypterPage.running = true;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => EncrypterPage(
                            beautify_mode: widget.beautify,
                            grid: Cell.cloneGrid(widget.grid),
                            ub: widget.ub,
                            lb: widget.lb,
                            ress: widget.ress))));
              }
              break;
            case 5:
              {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => AboutUs())));
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
                        timeGap: widget.time,
                        beautify_mode: widget.beautify,
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

  Widget toolsSection() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                  color: Colors.cyan,
                  width: 2,
                )),
                onPressed: () async {
                  int alivec = await DialogManager.openNumericalDialog(
                    max: widget.grid.length * widget.grid[0].length,
                    context: ctxt!,
                    title: "Input minimum number of cells required to be alive",
                  );
                  if (alivec == -1) {
                    return;
                  }
                  setState(() {
                    Cell.setRandomLive(widget.grid, alivec);
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Randomize Configuration",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ],
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.03,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                  color: Colors.cyan,
                  width: 2,
                )),
                onPressed: () {
                  setState(() {
                    Cell.clearGrid(widget.grid);
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Reset Board",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ],
                )),
          ],
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                fillColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.cyan.withOpacity(.32);
                  }
                  return Colors.cyan;
                }),
                activeColor: Colors.tealAccent,
                checkColor: Colors.white,
                value: widget.beautify,
                onChanged: (value) {
                  setState(() {
                    widget.beautify = value!;
                  });
                }),
            // SizedBox(
            //   width: MediaQuery.of(context).size.width * 0.002,
            // ),
            const Text(
              "Classic Mode",
              style: TextStyle(color: Colors.cyan),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.53,
            ),
          ],
        ),
      ],
    );
  }

  int calculateOptimalTimeFor({required int cols, required int rows}) {
    int total = rows * cols;
    int time = 0;
    if (total > 4000) {
      time = 11;
    } else if (total > 2500) {
      time = 30;
    } else if (total > 1000) {
      time = 50;
    } else {
      time = 200;
    }
    return time;
  }
}
