import 'package:flutter/material.dart';
import 'package:flutter_automata/pages/WelcomePage.dart';
import 'package:simple_icons/simple_icons.dart';

const String githubLink = "https://github.com/nikhil-RGB";
const String figmaLink = "https://www.figma.com/@chandrama";
const String devLink = "https://linktr.ee/nikhil_n67";
const String designerLink = "https://linktr.ee/chandramasaha";
const String devLinkedin = "https://www.linkedin.com/in/nikhil-narayanan-rgb/";
const String designerLinkedin = "https://www.linkedin.com/in/chandramasaha/";

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

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
          SizedBox(
            height: 0.044 * MediaQuery.of(context).size.height,
          ),
          aboutDesigner(context: context),
        ],
      ),
    );
  }

//generates the app bar for this screen
  Container generateAppBar({required BuildContext context}) {
    return Container(
      margin: const EdgeInsets.only(top: 35, bottom: 20),
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
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 50,
        right: 25,
        left: 25,
      ),
      margin: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0xFF161616),
      ),
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
            width: 22,
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
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "App Developer",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              generateClickableLabel(
                "@nikhil-rgb",
                githubLink,
                const Icon(
                  SimpleIcons.github,
                  color: Colors.cyan,
                  size: 18,
                ),
                context: context,
              ),
              generateClickableLabel(
                "@nikhil-narayanan-rgb",
                devLinkedin,
                const Icon(
                  SimpleIcons.linkedin,
                  color: Colors.cyan,
                  size: 16,
                ),
                context: context,
              ),
              generateClickableLabel(
                "More Links",
                devLink,
                const Icon(
                  SimpleIcons.chainlink,
                  color: Colors.cyan,
                  size: 18,
                ),
                context: context,
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget generateClickableLabel(String title, String link, Icon icon,
      {required BuildContext context}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: GestureDetector(
        onTap: () {
          launchURL(link, context);
        },
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

  //generates the container for developers information
  Container aboutDesigner({required BuildContext context}) {
    double imgWidth = MediaQuery.of(context).size.width * 0.36;
    double imgHeight = imgWidth;
    return Container(
      padding: const EdgeInsets.only(
        top: 50,
        bottom: 50,
        right: 25,
        left: 25,
      ),
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: const Color(0xFF161616),
      ),
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
                      image: AssetImage("assets/images/chandrama.jpg")),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 22,
          ),
          Column(
            // mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Chandrama",
                style: TextStyle(color: Colors.cyan, fontSize: 17),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "UI/UX designer",
                  style: TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              generateClickableLabel(
                "@chandrama",
                figmaLink,
                const Icon(
                  SimpleIcons.figma,
                  color: Colors.cyan,
                  size: 18,
                ),
                context: context,
              ),
              generateClickableLabel(
                "@chandramasaha",
                designerLinkedin,
                const Icon(
                  SimpleIcons.linkedin,
                  color: Colors.cyan,
                  size: 16,
                ),
                context: context,
              ),
              generateClickableLabel(
                "Other Links",
                designerLink,
                const Icon(
                  SimpleIcons.chainlink,
                  color: Colors.cyan,
                  size: 18,
                ),
                context: context,
              )
            ],
          ),
        ],
      ),
    );
  }
}
