import 'package:flutter/material.dart';
import 'package:flutter_automata/pages/InitializationPage.dart';

class WelcomePage extends StatelessWidget {
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
    return Scaffold(
      backgroundColor: Colors.black,
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
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => InitializationPage(x, y,
                          ub: ub, lb: lb, ress: ress))));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan),
            child: const Text("Proceed"),
          )
        ],
      ),
    );
  }
}
