// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';

import 'package:google_fonts/google_fonts.dart';

import '../models/Cell.dart';

class EncrypterPage extends StatefulWidget {
  @override
  State<EncrypterPage> createState() => _EncrypterPageState();
  static bool running = true;
  static bool automate = false;
  bool beautify_mode;
  int generationCount = 0;
  int ub;
  int lb;
  int ress;
  int timeGap;
  final List<List<Cell>> grid; //grid which will be used to build the board
  EncrypterPage(
      {super.key,
      required this.timeGap,
      required this.grid,
      required this.ub,
      required this.lb,
      // ignore: non_constant_identifier_names
      required this.ress,
      required this.beautify_mode});
}

class _EncrypterPageState extends State<EncrypterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController binary =
        TextEditingController(); //TextEditingController for binary
    TextEditingController ascii =
        TextEditingController(); //TextEditingController for ascii text area
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
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            infoField(txtc: binary, label: "Binary Text"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            Expanded(
              child: CellGrid(
                pretty: widget.beautify_mode,
                grid: widget.grid,
                initPage: false,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            infoField(txtc: ascii, label: "ASCII value"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (EncrypterPage.automate || !EncrypterPage.running) {
              return;
            }
            if (EncrypterPage.running) {
              setState(() {
                EncrypterPage.running = Cell.generationUpdate(
                    widget.grid, widget.lb, widget.ub, widget.ress);
                ++widget.generationCount;
              });
              if (!EncrypterPage.running) {
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
          backgroundColor: (EncrypterPage.automate || (!EncrypterPage.running))
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
                  EncrypterPage.automate = false;
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
                    side: BorderSide(
                  color: (EncrypterPage.automate) ? Colors.grey : Colors.cyan,
                  width: 2,
                )),
                onPressed: () {
                  if (EncrypterPage.automate) {
                    return;
                  }
                  setState(() {
                    EncrypterPage.running = false;
                  });
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.delete_forever_outlined,
                      color:
                          (EncrypterPage.automate) ? Colors.grey : Colors.cyan,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.01,
                    ),
                    Text(
                      "FORCE KILL SYSTEM",
                      style: TextStyle(
                        color: (EncrypterPage.automate)
                            ? Colors.grey
                            : Colors.cyan,
                      ),
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
                          !EncrypterPage.running) {
                        return Colors.cyan.withOpacity(.32);
                      }
                      return Colors.cyan;
                    }),
                    activeColor: Colors.tealAccent,
                    checkColor: Colors.white,
                    value: EncrypterPage.automate,
                    onChanged: (value) {
                      if (!EncrypterPage.running) {
                        return;
                      }
                      setState(() {
                        EncrypterPage.automate = value!;
                      });
                      if (EncrypterPage.automate) {
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
    while (EncrypterPage.running && EncrypterPage.automate) {
      await Future.delayed(Duration(milliseconds: widget.timeGap), () async {
        setState(() {
          EncrypterPage.running = Cell.generationUpdate(
              widget.grid, widget.lb, widget.ub, widget.ress);
          ++widget.generationCount;
        });
        if (!EncrypterPage.running) {
          setState(() {
            EncrypterPage.automate = false;
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

  Widget infoField(
      {required TextEditingController txtc, required String label}) {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.61,
        child: TextField(
            readOnly: true,
            style: GoogleFonts.sourceCodePro(color: Colors.cyan),
            controller: txtc,
            decoration: InputDecoration(
              labelText: label,
              alignLabelWithHint: true,
              labelStyle: GoogleFonts.sourceCodePro(
                  fontSize: 15,
                  color: Colors.cyan,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w400),
              floatingLabelStyle: GoogleFonts.sourceCodePro(color: Colors.cyan),
              hintStyle:
                  GoogleFonts.sourceCodePro(color: Colors.cyan, fontSize: 14),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 3, color: Colors.cyan),
                  borderRadius: BorderRadius.circular(12.0)),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                    width: 3, color: Colors.teal), //<-- SEE HERE
                borderRadius: BorderRadius.circular(12.0),
              ),
            )),
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
