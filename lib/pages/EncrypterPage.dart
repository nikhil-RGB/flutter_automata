// ignore_for_file: must_be_immutable

import 'dart:convert';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_automata/CellGrid.dart';
import 'package:flutter_automata/pages/CipherPage.dart';
import 'package:flutter_automata/util/DialogManager.dart';

import 'package:google_fonts/google_fonts.dart';

import '../models/Cell.dart';

class EncrypterPage extends StatefulWidget {
  @override
  State<EncrypterPage> createState() => _EncrypterPageState();
  static bool running = true;

  bool beautify_mode;
  int generationCount = 0;
  int ub;
  int lb;
  int ress;

  final List<List<Cell>> grid; //grid which will be used to build the board
  EncrypterPage(
      {super.key,
      required this.grid,
      required this.ub,
      required this.lb,
      // ignore: non_constant_identifier_names
      required this.ress,
      required this.beautify_mode});
}

class _EncrypterPageState extends State<EncrypterPage> {
  TextEditingController secKey =
      TextEditingController(); //TextEditingController for binary
  TextEditingController genIv =
      TextEditingController(); //TextEditingController for ascii text area

  enc.Key key = enc.Key.fromSecureRandom(10);
  enc.IV iv = enc.IV.fromSecureRandom(10);
  @override
  Widget build(BuildContext context) {
    String binary = extractBinaryFromGrid();
    String ascii = parseUnix(binary);
    List<dynamic> params = generateKeyIv(ascii);

    key = params[0];
    iv = params[1];

    secKey.text = key.base64;
    genIv.text = iv.base64;

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
            SizedBox(height: MediaQuery.of(context).size.height * 0.01),
            infoField(txtc: secKey, label: "Secret Key(base 64)"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            infoField(txtc: genIv, label: "Initialization Vector(base 64)"),
            SizedBox(height: MediaQuery.of(context).size.height * 0.03),
            Expanded(
              flex: 8,
              child: CellGrid(
                pretty: widget.beautify_mode,
                grid: widget.grid,
                initPage: false,
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.0025),
            Center(child: viewerButton(context)),
            SizedBox(height: MediaQuery.of(context).size.height * 0.004),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (!EncrypterPage.running) {
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
          backgroundColor: (!EncrypterPage.running) ? Colors.grey : Colors.cyan,
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

  Widget infoField(
      {required TextEditingController txtc, required String label}) {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        child: TextField(
            minLines: 1,
            maxLines: 3,
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

  //This method extracts a binary number from the current grid by coverting live cells to 1 and dead ones to 0
  String extractBinaryFromGrid() {
    String binary = "";
    for (int i = 0; i < widget.grid.length; ++i) {
      for (int j = 0; j < widget.grid[i].length; ++j) {
        binary += (widget.grid[i][j].state) ? "1" : "0";
      }
    }
    return binary;
  }

  String parseUnix(String binary) {
    String unix = "";
    for (int i = 0; i < binary.length; ++i) {
      String sub = "";
      if ((i + 12) <= binary.length) {
        sub = binary.substring(i, (i = i + 12));
        --i;
      } else {
        sub = binary.substring(i);
        i = binary.length;
      }
      unix += String.fromCharCode(int.parse(sub, radix: 2));
    }
    return unix;
  }

  //generates a symmetric encryption key and
  List<dynamic> generateKeyIv(String ascii) {
    String keySource = ascii.substring(0, (ascii.length) ~/ 2);
    String initializationVectorSource = ascii.substring((ascii.length) ~/ 2);
    // Convert the ascii string obtained from the first page  to bytes
    List<int> bytes = utf8.encode(keySource);
    // Generate a 128-bit AES key from the bytes using SHA-256
    List<int> keyBytes = sha256.convert(bytes).bytes.sublist(0, 16);
    // Convert the key bytes to a string
    enc.Key key = enc.Key.fromBase64(base64.encode(keyBytes));

    List<int> bytesIV = utf8.encode(initializationVectorSource);
    List<int> ivBytes = sha256.convert(bytesIV).bytes.sublist(0, 16);

    enc.IV iv = enc.IV.fromBase64(base64.encode(ivBytes));
    return [key, iv];
  }

  Widget viewerButton(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
          side: BorderSide(
        color: (!EncrypterPage.running) ? Colors.grey : Colors.cyan,
        width: 2,
      )),
      onPressed: () {
        if (!EncrypterPage.running) {
          return;
        }
        // DialogManager.openInfoDialog(
        //     details: "Not implemented yet!", context: context);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => CipherPage(
                      secKey: key,
                      genIv: iv,
                      generationCount: widget.generationCount,
                    ))));
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Icon(
            Icons.visibility_outlined,
            color: (!EncrypterPage.running) ? Colors.grey : Colors.cyan,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.04,
          ),
          Text(
            "AES Encryption Demo",
            style: TextStyle(
                color: (!EncrypterPage.running) ? Colors.grey : Colors.cyan),
          ),
        ],
      ),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
