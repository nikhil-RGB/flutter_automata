import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CipherPage extends StatefulWidget {
  static List<String> modes = ["Cipher", "Decipher"];

  CipherPage({super.key});

  @override
  State<CipherPage> createState() => _CipherPageState();
}

class _CipherPageState extends State<CipherPage> {
  String _currentMode = "Cipher";
  TextEditingController input = TextEditingController();
  TextEditingController output = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // resizeToAvoidBottomInset: false,
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
              modeController(),
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
    );
  }

  Widget generateTextField(
      {required BuildContext context, required TextEditingController control}) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextField(
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
              (_currentMode == "Cipher") ? "AES Encrypt" : "AES Decrypt",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        onPressed: () {},
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
}
