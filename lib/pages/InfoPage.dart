import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  static const String data =
      "These encryption keys are generated using the current state of the Cellular Automaton:\n1) At the time of key generation, the current state/generation of the cellular automaton is converted into a binary string--> 1 for alive/0 for dead.\n2) This binary string is then divided into substrings of 12, and each substring is converted into it's decimal equivalent number.\n3) These numbers are then each encoded into a character.\n4) A string of jargon characters is thus generated. This string is then split into two halves which are used to generate the secret key, and initialization vector.\n5) Each of these two halves then undergo UTF-8 encoding and SHA-256 hashing.\n6) The first 16 bytes of the two halves are then converted into the key and IV respectively.\n7) The algorithm used to test the symmetric key so-generated is AES(Advanced Encryption Standard).\nI used the encrypter package for implementing the AES algorithm, since my purpose was only to showcase key generation, not to re-implement any encryption algorithm itself.";

  const InfoPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(10),
          child: IconButton(
              color: Colors.cyan,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        title: const Text(
          "Key/IV Generation",
          style: TextStyle(color: Colors.cyan),
        ),
      ),
      backgroundColor: Colors.black,
      body: const Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              data,
              style: TextStyle(color: Colors.cyan, fontSize: 16),
            ),
          ),
        ),
      ),
    ));
  }
}
