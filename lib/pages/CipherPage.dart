import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CipherPage extends StatefulWidget {
  const CipherPage({super.key});

  @override
  State<CipherPage> createState() => _CipherPageState();
}

class _CipherPageState extends State<CipherPage> {
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
              generateTextField(context: context, control: input),
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.015,
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
}
