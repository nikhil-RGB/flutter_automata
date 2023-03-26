import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_automata/pages/InitializationPage.dart';
import 'package:flutter_automata/util/DialogManager.dart';

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
  static const String welcomeMessage =
      "Welcome to the Flutter Automata !\n\n\n\nA cellular automaton (CA) is a collection of cells arranged in a grid of specified shape, such that each cell changes state as a function of time, according to a defined set of rules driven by the states of neighboring cells.\n\nHere, you can create your own system of living cells with your own set of rules!";
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
        backgroundColor: Colors.black,
        appBar: AppBar(
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
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text(
                welcomeMessage,
                style: TextStyle(color: Colors.cyan, fontSize: 17),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
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
            )
          ],
        ),
      ),
    );
  }
}
