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
  int timeGap;
  final List<List<Cell>> grid; //grid which will be used to build the board
  AutomatonPage(
      {super.key,
      required this.timeGap,
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
            Expanded(
              child: CellGrid(
                pretty: widget.beautify_mode,
                grid: widget.grid,
                initPage: false,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (AutomatonPage.automate || !AutomatonPage.running) {
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
          backgroundColor: (AutomatonPage.automate || (!AutomatonPage.running))
              ? Colors.grey
              : Colors.cyan,
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
      style:
          TextStyle(color: (AutomatonPage.running) ? Colors.cyan : Colors.grey),
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
                  AutomatonPage.automate = false;
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
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 8.0),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: BorderSide(
                    color: (AutomatonPage.automate || (!AutomatonPage.running))
                        ? Colors.grey
                        : Colors.cyan,
                    width: 2,
                  )),
                  onPressed: () {
                    if (AutomatonPage.automate || (!AutomatonPage.running)) {
                      return;
                    }
                    setState(() {
                      AutomatonPage.running = false;
                    });
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.delete_forever_outlined,
                        color:
                            (AutomatonPage.automate || (!AutomatonPage.running))
                                ? Colors.grey
                                : Colors.cyan,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.01,
                      ),
                      Text(
                        "FORCE KILL SYSTEM",
                        style: TextStyle(
                          color: (AutomatonPage.automate ||
                                  (!AutomatonPage.running))
                              ? Colors.grey
                              : Colors.cyan,
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.014,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 24,
                    width: 24,
                    child: Checkbox(
                        fillColor: MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                          if (states.contains(MaterialState.disabled) ||
                              !AutomatonPage.running) {
                            return Colors.grey;
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
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.01,
                  // ),
                  Text(
                    " Automate progression",
                    style: TextStyle(
                        color: (AutomatonPage.running)
                            ? Colors.cyan
                            : Colors.grey),
                  ),
                ],
              ),
            ],
          ),
          // SizedBox(
          //   width: MediaQuery.of(context).size.width * 0.4,
          // )
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.08,
          ),
          _ruleInfo(),
        ],
      ),
    );
  }

  Future automateCalculation() async {
    while (AutomatonPage.running && AutomatonPage.automate) {
      await Future.delayed(Duration(milliseconds: widget.timeGap), () async {
        setState(() {
          AutomatonPage.running = Cell.generationUpdate(
              widget.grid, widget.lb, widget.ub, widget.ress);
          ++widget.generationCount;
        });
        if (!AutomatonPage.running) {
          setState(() {
            AutomatonPage.automate = false;
          });

          await openInfoDialog(
              context: context,
              details:
                  "The Grid system has either stabilized or been force killed.\nNo further growth possible!",
              title: "Automaton Stabilized");
        }
      });
    }
  }

  Widget _ruleInfo() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: const EdgeInsets.only(left: 10.0, right: 10.0),
      width: MediaQuery.of(context).size.width * 0.35,
      decoration: BoxDecoration(
        border: Border.all(
            width: 2,
            color: (AutomatonPage.running) ? Colors.cyan : Colors.grey),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
          Text(
            "Lower Bound: ${widget.lb}",
            style: TextStyle(
                color: (AutomatonPage.running) ? Colors.cyan : Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            "Upper Bound: ${widget.ub}",
            style: TextStyle(
                color: (AutomatonPage.running) ? Colors.cyan : Colors.grey),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.01,
          ),
          Text(
            "Ress Bound:  ${widget.ress}",
            style: TextStyle(
                color: (AutomatonPage.running) ? Colors.cyan : Colors.grey),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.01,
          // ),
          // Text(
          //   "time gap(ms): ${widget.timeGap}",
          //   style: const TextStyle(color: Colors.cyan),
          // ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.001,
          ),
        ],
      ),
    );
  }
}
