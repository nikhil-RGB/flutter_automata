import 'package:flutter/material.dart';
import 'package:simple_icons/simple_icons.dart';

class AboutUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          generateAppBar(
            context: context,
          ),
          aboutDev(context: context),
        ],
      ),
    );
  }

//generates the app bar for this screen
  Container generateAppBar({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      child: Row(
        children: [
          IconButton(
            color: Colors.cyan,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back),
          ),
          const SizedBox(
            width: 20,
          ),
          const Text(
            "Go back",
            style: TextStyle(color: Colors.cyan),
          )
        ],
      ),
    );
  }

  //generates the container for developers information
  Container aboutDev({required BuildContext context}) {
    double imgWidth = MediaQuery.of(context).size.width * 0.36;
    double imgHeight = imgWidth;
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(color: Color(0xFF161616)),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            fit: StackFit.loose,
            children: [
              Container(
                height: imgHeight,
                width: imgWidth,
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      color: Colors.cyan,
                      width: 1.0,
                    )),
              ),
              Positioned(
                bottom: 9,
                right: 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.cyan, width: 1.0),
                  ),
                  width: imgWidth,
                  height: imgHeight,
                  child: const Image(
                      image: AssetImage("assets/images/nikhil.png")),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Nikhil Narayanan",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
              const Text(
                "App Developer",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              generateClickableLabel(
                  "@nikhil-rgb",
                  "",
                  const Icon(
                    SimpleIcons.github,
                    color: Colors.cyan,
                    size: 18,
                  )),
              generateClickableLabel(
                  "@nikhil-narayanan-rgb",
                  "",
                  const Icon(
                    SimpleIcons.linkedin,
                    color: Colors.cyan,
                    size: 16,
                  ))
            ],
          ),
        ],
      ),
    );
  }

  Widget generateClickableLabel(String title, String link, Icon icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 7,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}
