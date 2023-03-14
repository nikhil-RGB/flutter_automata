import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogManager {
  static Future openNumericalDialog({
    required BuildContext context,
    String title = "Numerical Input Required!",
    required int max,
  }) {
    TextEditingController num_dialog = TextEditingController();
    final GlobalKey<FormState> _formKeynum = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              title,
              style: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            backgroundColor: const Color(0XFF004246),
            content: Form(
              key: _formKeynum,
              child: TextFormField(
                style: const TextStyle(color: Colors.cyan),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: num_dialog,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: "Number of live cells",
                  alignLabelWithHint: true,
                  labelStyle: GoogleFonts.roboto(
                      fontSize: 15,
                      color: Colors.cyan,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400),
                  floatingLabelStyle: const TextStyle(color: Colors.cyan),
                  hintStyle: const TextStyle(color: Colors.cyan, fontSize: 14),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Colors.cyan),
                      borderRadius: BorderRadius.circular(50.0)),
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                        width: 3, color: Colors.teal), //<-- SEE HERE
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 3, color: Colors.redAccent),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
                validator: (value) {
                  try {
                    if (int.parse(value!) > max) {
                      return "Live cells can't exceed total cell count";
                    }
                  } catch (_) {
                    return "Invalid input!";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //cancel
                  Navigator.pop(context, -1);
                },
                child: Text("Cancel", style: GoogleFonts.dmSans()),
              ),
              ElevatedButton(
                onPressed: () {
                  //confirm
                  if (_formKeynum.currentState!.validate()) {
                    //passing data back, it is valid
                    Navigator.pop(context, int.parse(num_dialog.text));
                  }
                },
                child: Text("Confirm", style: GoogleFonts.dmSans()),
              ),
            ],
          );
        });
  }

  static Future openInitializeGridDialog({
    required BuildContext context,
    String title = "Initialize the Grid",
    required int maxRows,
    required int minRows,
    required int maxColumns,
    required int minColumns,
  }) {
    TextEditingController rows = TextEditingController();
    TextEditingController columns = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              title,
              style: GoogleFonts.dmSans(
                color: Colors.cyan,
              ),
            ),
            backgroundColor: const Color(0XFF004246),
            content: Form(
              key: formKey,
              child: Column(
                children: [
                  TextFormField(
                    style: const TextStyle(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: rows,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Number of Rows",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle: const TextStyle(color: Colors.cyan),
                      hintStyle:
                          const TextStyle(color: Colors.cyan, fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.cyan),
                          borderRadius: BorderRadius.circular(50.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: Colors.teal), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    validator: (value) {
                      try {
                        int rows = int.parse(value!);
                        if (rows <= 1) {
                          return "Rows can never be less than or equal to 1";
                        }
                        if (rows > maxRows || rows < minRows) {
                          return "Number of rows cannot exceed $maxRows and cannot be lesser than $minRows";
                        }
                      } catch (_) {
                        return "Invalid input!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    style: const TextStyle(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: columns,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Number of Columns",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.roboto(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle: const TextStyle(color: Colors.cyan),
                      hintStyle:
                          const TextStyle(color: Colors.cyan, fontSize: 14),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.cyan),
                          borderRadius: BorderRadius.circular(50.0)),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 3, color: Colors.teal), //<-- SEE HERE
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.redAccent),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    validator: (value) {
                      try {
                        int columns = int.parse(value!);
                        if (columns <= 1) {
                          return "Columns can never be less than or equal to 1";
                        }
                        if (columns > maxColumns || columns < minColumns) {
                          return "Number of columns cannot exceed $maxColumns and cannot be lesser than $minColumns";
                        }
                      } catch (_) {
                        return "Invalid input!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  //cancel
                  Navigator.pop(context, List.empty());
                },
                child: Text("Cancel", style: GoogleFonts.dmSans()),
              ),
              ElevatedButton(
                onPressed: () {
                  //confirm
                  if (formKey.currentState!.validate()) {
                    //passing data back, it is valid
                    Navigator.pop(context,
                        [int.parse(rows.text), int.parse(columns.text)]);
                  }
                },
                child: Text("Confirm", style: GoogleFonts.dmSans()),
              ),
            ],
          );
        });
  }
}
