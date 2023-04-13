// ignore_for_file: must_be_immutable

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_automata/pages/InitializationPage.dart';
import 'package:flutter_automata/util/DialogManager.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatelessWidget {
  static const int minRows = 2;
  static const int maxRows = 70;
  static const int minCols = 2;
  static const int maxCols = 70;
  String s = "";
  int x;
  int y;
  int ub;
  int lb;
  int ress;
  static const String CAinfo =
      "https://en.wikipedia.org/wiki/Cellular_automaton"; //URL to be launched for viewing cellular automaton info
  static const String GOLinfo =
      "https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life"; //URL to be lauched for game of life info
  // static const String welcomeMessage =
  //     "Welcome to Game of Life !\n\n\nA Cellular Automaton (CA) is a collection of cells arranged in a grid of specified shape, such that each cell changes state as a function of time, according to a defined set of rules driven by the states of neighboring cells.\n\nGame of Life is a particular kind of cellular automaton, introduced by John Connway in 1970, consisting of 2-state cells(dead or alive).\n\nThese automatons form self-generative patterns, and have applications in fields like cryptography and traffic simulation. \nHere, you can create your own system of living cells with your own set of rules!";
  static const String mssg1 = "Welcome to Game of Life !\n\n\nA ";
  static const String hyperlink1 = "Cellular Automaton";
  static const String mssg2 =
      " (CA) is a collection of cells arranged in a grid of specified shape, such that each cell changes state as a function of time, according to a defined set of rules driven by the states of neighboring cells.\n\n";
  static const String hyperlink2 = "Game of Life";
  static const String mssg3 =
      " is a particular kind of cellular automaton, introduced by John Connway in 1970, consisting of 2-state cells(dead or alive).\n\nThese automatons form self-generative patterns, and have applications in fields like cryptography and traffic simulation. \n\nHere, you can create your own system of living cells with your own set of rules!";

  WelcomePage(
      {super.key,
      required this.x,
      required this.y,
      required this.ub,
      required this.lb,
      required this.ress});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 12.0),
            child: IconButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              icon: const Icon(Icons.exit_to_app_outlined),
              color: Colors.cyan,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: const EdgeInsets.only(right: 7, left: 7),
                // child: Text(
                //   welcomeMessage,
                //   style: TextStyle(color: Colors.cyan, fontSize: 17),
                //   textAlign: TextAlign.center,
                // ),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: mssg1,
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.cyan,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                          text: hyperlink1,
                          style: GoogleFonts.sourceCodePro(
                            color: Colors.transparent,
                            shadows: [
                              const Shadow(
                                  offset: Offset(0, -1),
                                  color: Colors.cyanAccent)
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.cyanAccent,
                            fontSize: 17,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              launchURL(CAinfo, context);
                            }),
                      TextSpan(
                        text: mssg2,
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.cyan,
                          fontSize: 17,
                        ),
                      ),
                      TextSpan(
                        text: hyperlink2,
                        style: GoogleFonts.sourceCodePro(
                          decoration: TextDecoration.underline,
                          color: Colors.transparent,
                          shadows: [
                            const Shadow(
                                offset: Offset(0, -1), color: Colors.cyanAccent)
                          ],
                          decorationColor: Colors.cyanAccent,
                          fontSize: 17,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchURL(GOLinfo, context);
                          },
                      ),
                      TextSpan(
                        text: mssg3,
                        style: GoogleFonts.sourceCodePro(
                          color: Colors.cyan,
                          fontSize: 17,
                        ),
                      ),
                    ],
                  ),
                )),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.071,
            ),
            ElevatedButton(
              onPressed: () async {
                List input = await DialogManager.openInitializeGridDialog(
                    context: context,
                    maxRows: maxRows,
                    minRows: minRows,
                    maxColumns: maxCols,
                    minColumns: minCols);
                if (input.isEmpty) {
                  return;
                }

                // ignore: use_build_context_synchronously
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => InitializationPage(
                            input[0], input[1],
                            ub: ub, lb: lb, ress: ress))));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
              child: const Text("Proceed"),
            ),
          ],
        ),
      ),
    );
  }
}

//launches information url.
launchURL(String urlInp, BuildContext context) async {
  Uri url = Uri.parse(urlInp);

  if (await launchUrl(url)) {
    await launchUrl(url);
  } else {
    // ignore: use_build_context_synchronously
    DialogManager.openInfoDialog(
        details: "Could not launch $url", context: context);
  }
}
