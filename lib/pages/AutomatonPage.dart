// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';

import 'package:google_fonts/google_fonts.dart';

import '../models/Cell.dart';

class AutomatonPage extends StatefulWidget {
  @override
  State<AutomatonPage> createState() => _AutomatonPageState();
  static bool running = true;
  static bool automate = false;
  bool beautify_mode;
  int generationCount = 0;
  int ub;
  int lb;
  int ress;
  final List<List<Cell>> grid; //grid which will be used to build the board
  AutomatonPage(
      {super.key,
      required this.grid,
      required this.ub,
      required this.lb,
      // ignore: non_constant_identifier_names
      required this.ress,
      required this.beautify_mode});
}

class _AutomatonPageState extends State<AutomatonPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // appBar: AppBar(
        //   backgroundColor: Colors.black,
        //   actions: [
        //     generationLabel(),
        //     SizedBox(
        //       width: MediaQuery.of(context).size.width * 0.06,
        //     ),
        //     IconButton(
        //         color: Colors.cyan,
        //         onPressed: () {
        //           Phoenix.rebirth(context);
        //         },
        //         icon: const Icon(Icons.restart_alt_rounded))
        //   ],
        // ),
        body: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            generateToolBar(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            generateFunctionalities(),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            CellGrid(
              pretty: widget.beautify_mode,
              grid: widget.grid,
              initPage: false,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (AutomatonPage.automate) {
              return;
            }
            if (AutomatonPage.running) {
              setState(() {
                AutomatonPage.running = Cell.generationUpdate(
                    widget.grid, widget.lb, widget.ub, widget.ress);
                ++widget.generationCount;
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
          backgroundColor: AutomatonPage.automate ? Colors.grey : Colors.cyan,
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

  Widget generationLabel() {
    String lab = "";
    int gc = widget.generationCount;
    lab = gc.toString();
    if (gc < 10) {
      lab = "0$lab";
    }
    return Text(
      "Generation Count: ${widget.generationCount}",
      style: const TextStyle(color: Colors.cyan),
    );
  }

  Widget generateToolBar() {
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.01,
            ),
            const Text(
              "Go Back",
              style: TextStyle(color: Colors.white),
            )
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.23,
        ),
        generationLabel(),
      ],
    );
  }

  Widget generateFunctionalities() {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                    side: const BorderSide(
                  color: Colors.cyan,
                  width: 2,
                )),
                onPressed: () {
                  setState(() {
                    AutomatonPage.running = false;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.delete_forever_outlined,
                      color: Colors.cyan,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    const Text(
                      "FORCE KILL SYSTEM",
                      style: TextStyle(color: Colors.cyan),
                    ),
                  ],
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.008,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Checkbox(
                    fillColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.disabled) ||
                          !AutomatonPage.running) {
                        return Colors.cyan.withOpacity(.32);
                      }
                      return Colors.cyan;
                    }),
                    activeColor: Colors.tealAccent,
                    checkColor: Colors.white,
                    value: AutomatonPage.automate,
                    onChanged: (value) {
                      if (!AutomatonPage.running) {
                        return;
                      }
                      setState(() {
                        AutomatonPage.automate = value!;
                      });
                      if (AutomatonPage.automate) {
                        automateCalculation();
                      }
                    }),
                // SizedBox(
                //   width: MediaQuery.of(context).size.width * 0.01,
                // ),
                const Text(
                  "Automate progression",
                  style: TextStyle(color: Colors.cyan),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.4,
        )
      ],
    );
  }

  Future automateCalculation() async {
    while (AutomatonPage.running && AutomatonPage.automate) {
      await Future.delayed(const Duration(milliseconds: 100), () async {
        setState(() {
          AutomatonPage.running = Cell.generationUpdate(
              widget.grid, widget.lb, widget.ub, widget.ress);
          ++widget.generationCount;
        });
        if (!AutomatonPage.running) {
          await openInfoDialog(
              context: context,
              details:
                  "The Grid system has either stabilized or been force killed.\nNo further growth possible!",
              title: "Automaton Stabilized");
        }
      });
    }
  }
}
