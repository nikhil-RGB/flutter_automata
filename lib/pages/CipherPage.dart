// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_automata/util/DialogManager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:encrypt/encrypt.dart' as enc;
import 'package:crypto/crypto.dart';

class CipherPage extends StatefulWidget {
  static List<String> modes = ["Cipher", "Decipher"];

  enc.Key secKey;
  enc.IV genIv;
  int generationCount;
  CipherPage({
    super.key,
    required this.secKey,
    required this.genIv,
    required this.generationCount,
  });

  @override
  State<CipherPage> createState() => _CipherPageState();
}

class _CipherPageState extends State<CipherPage> {
  String _currentMode = "Cipher";
  TextEditingController input = TextEditingController();
  TextEditingController output = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isKeyBoardOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        // resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: true,

        appBar: (!isKeyBoardOpen)
            ? AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                leading: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_outlined),
                    color: Colors.cyan,
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: generationLabel(),
                  ),
                ],
              )
            : null,
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SizedBox(
                //   height: MediaQuery.of(context).size.width * 0.15,
                // ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.02,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    modeController(),
                    generateInfoButton(),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                generateTextField(context: context, control: input),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                generateControlButton(),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.01,
                ),
                generateTextField(context: context, control: output),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.015,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget generateTextField(
      {required BuildContext context, required TextEditingController control}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
        readOnly: control == output,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.cyan,
        ),
        controller: control,
        keyboardType: TextInputType.multiline,
        maxLines: 11,
        decoration: InputDecoration(
          prefixIcon: (control == input)
              ? IconButton(
                  color: Colors.cyan,
                  onPressed: () {
                    setState(() {
                      (Clipboard.getData(Clipboard.kTextPlain)).then((value) {
                        String text = (value?.text) ?? "";
                        control.text = text;
                      });
                    });
                  },
                  icon: const Icon(Icons.paste_rounded),
                )
              : IconButton(
                  color: Colors.cyan,
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: output.text));
                  },
                  icon: const Icon(Icons.copy_all_rounded),
                ),
          enabledBorder: createInputBorder(),
          hintText: "Enter text here",
          hintStyle: const TextStyle(color: Colors.cyan),
          focusedBorder: createFocusBorder(),
        ),
      ),
    );
  }

  OutlineInputBorder createInputBorder() {
    //return type is OutlineInputBorder
    return const OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.cyan,
          width: 3,
        ));
  }

  OutlineInputBorder createFocusBorder() {
    return const OutlineInputBorder(
        //Outline border type for TextFeild
        borderRadius: BorderRadius.all(Radius.circular(20)),
        borderSide: BorderSide(
          color: Colors.white,
          width: 3,
        ));
  }

  Widget generateControlButton() {
    return Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            side: const BorderSide(
          color: Colors.cyan,
          width: 2,
        )),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            const Icon(
              Icons.enhanced_encryption,
              color: Colors.black,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.02,
            ),
            Text(
              (_currentMode == "Cipher")
                  ? "Automata AES Encrypt"
                  : "Automata AES Decrypt",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onPressed: () {
          if (input.text.isEmpty) {
            return;
          }
          String result = doEncryptOperation(_currentMode == "Cipher");
          setState(() {
            output.text = result;
          });
        },
      ),
    );
  }

  Widget modeController() {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.cyan,
        ),
        child: DropdownButton(
            underline: Container(
              height: 0,
            ),
            borderRadius: BorderRadius.circular(12),
            hint: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Select Mode",
                style: GoogleFonts.sourceCodePro(
                  color: Colors.black,
                ),
              ),
            ),
            dropdownColor: Colors.cyan,
            style: GoogleFonts.sourceCodePro(
                color: Colors.black, //<-- SEE HERE
                fontSize: 15,
                fontWeight: FontWeight.bold),
            icon: const Padding(
              padding: EdgeInsets.only(right: 5.0),
              child: Icon(
                Icons.arrow_drop_down_circle,
                color: Colors.black,
                size: 16,
              ),
            ),
            items: CipherPage.modes.map((String val) {
              return DropdownMenuItem(
                value: val,
                child: Text(val),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _currentMode = newValue!;
                _modeSwitch();
              });
            }),
      ),
    );
  }

  void _modeSwitch() {
    input.clear();
    output.clear();
  }

  // true for cipher/false for decipher
  // String doOperation(bool mode) {
  //   String inp = input.text;
  //   String output = "";
  //   for (int i = 0, j = 0; i < inp.length; ++i) {
  //     if (mode) {
  //       output +=
  //           String.fromCharCode(inp.codeUnitAt(i) + widget.ascii.codeUnitAt(j));
  //     } else {
  //       output +=
  //           String.fromCharCode(inp.codeUnitAt(i) - widget.ascii.codeUnitAt(j));
  //     }
  //     ++j;
  //     if (j >= widget.ascii.length) {
  //       j = 0;
  //     }
  //   }
  //   return output;
  // }

  //Pass true for encryption, false for decryption
  String doEncryptOperation(bool mode) {
    enc.Encrypter encrypter = enc.Encrypter(enc.AES(widget.secKey));
    String result = "";
    try {
      if (mode) {
        result = encrypter.encrypt(input.text, iv: widget.genIv).base64;
      } else {
        result = encrypter
            .decrypt(enc.Encrypted.fromBase64(input.text), iv: widget.genIv)
            .toString();
      }
    } on Exception catch (e) {
      DialogManager.openInfoDialog(
          details: "Error performing operation!", context: context);
    }
    return result;
  }

  Widget generationLabel() {
    String lab = "";
    int gc = widget.generationCount;
    lab = gc.toString();
    if (gc < 10) {
      lab = "0$lab";
    }
    return Text(
      "Generation Count: ${widget.generationCount}",
      style: const TextStyle(
        color: Colors.cyan,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget generateInfoButton() {
    return Container(
      margin: EdgeInsets.only(left: 15.0, right: 8.0),
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
              side: BorderSide(
            color: Colors.cyan,
            width: 2,
          )),
          onPressed: () {
            DialogManager.showEncryptionInfo(
                context: context,
                key: widget.secKey.base64,
                iv: widget.genIv.base64);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.view_agenda_outlined,
                color: Colors.cyan,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.02,
              ),
              Text(
                "View key/IV data",
                style: TextStyle(color: Colors.cyan),
              ),
            ],
          )),
    );
  }
}
