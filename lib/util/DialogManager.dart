// ignore_for_file: non_constant_identifier_names

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
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<FormState> _formKeynum = GlobalKey<FormState>();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              title,
              style: GoogleFonts.sourceCodePro(
                color: Colors.cyan,
              ),
            ),
            backgroundColor: const Color(0XFF004246),
            content: Form(
              key: _formKeynum,
              child: TextFormField(
                style: GoogleFonts.sourceCodePro(color: Colors.cyan),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: num_dialog,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                ],
                decoration: InputDecoration(
                  labelText: "Number of live cells",
                  alignLabelWithHint: true,
                  labelStyle: GoogleFonts.sourceCodePro(
                      fontSize: 15,
                      color: Colors.cyan,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.w400),
                  floatingLabelStyle:
                      GoogleFonts.sourceCodePro(color: Colors.cyan),
                  hintStyle: GoogleFonts.sourceCodePro(
                      color: Colors.cyan, fontSize: 14),
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
                child: Text("Cancel", style: GoogleFonts.sourceCodePro()),
              ),
              ElevatedButton(
                onPressed: () {
                  //confirm
                  if (_formKeynum.currentState!.validate()) {
                    //passing data back, it is valid
                    Navigator.pop(context, int.parse(num_dialog.text));
                  }
                },
                child: Text("Confirm", style: GoogleFonts.sourceCodePro()),
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
              style: GoogleFonts.sourceCodePro(
                color: Colors.cyan,
              ),
            ),
            backgroundColor: const Color(0XFF004246),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: GoogleFonts.sourceCodePro(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: rows,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Number of Rows",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle:
                          GoogleFonts.sourceCodePro(color: Colors.cyan),
                      hintStyle: GoogleFonts.sourceCodePro(
                          color: Colors.cyan, fontSize: 14),
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
                    style: GoogleFonts.sourceCodePro(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: columns,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Number of Columns",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle:
                          GoogleFonts.sourceCodePro(color: Colors.cyan),
                      hintStyle: GoogleFonts.sourceCodePro(
                          color: Colors.cyan, fontSize: 14),
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
                child: Text("Cancel", style: GoogleFonts.sourceCodePro()),
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
                child: Text("Confirm", style: GoogleFonts.sourceCodePro()),
              ),
            ],
          );
        });
  }

  static Future openInfoDialog(
          {String info_title = "Information",
          required String details,
          required BuildContext context}) =>
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              info_title,
              style: const TextStyle(
                color: Colors.cyan,
              ),
            ),
            content: Text(
              details,
              style: const TextStyle(
                color: Colors.cyan,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Ok"),
              ),
            ],
            backgroundColor: const Color(0XFF004246),
          );
        },
      );

  static Future openRuleChangeDialog({required BuildContext context}) {
    TextEditingController lower_bound = TextEditingController();
    TextEditingController upper_bound = TextEditingController();
    TextEditingController ressurection = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6.0))),
            title: Text(
              "Change Rules",
              style: GoogleFonts.sourceCodePro(
                color: Colors.cyan,
              ),
            ),
            backgroundColor: const Color(0XFF004246),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    style: GoogleFonts.sourceCodePro(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: lower_bound,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Lower Bound",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle:
                          GoogleFonts.sourceCodePro(color: Colors.cyan),
                      hintStyle: GoogleFonts.sourceCodePro(
                          color: Colors.cyan, fontSize: 14),
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
                    validator: _validateRule,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    style: GoogleFonts.sourceCodePro(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: upper_bound,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Upper Bound",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle:
                          GoogleFonts.sourceCodePro(color: Colors.cyan),
                      hintStyle: GoogleFonts.sourceCodePro(
                          color: Colors.cyan, fontSize: 14),
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
                    validator: _validateRule,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  TextFormField(
                    style: GoogleFonts.sourceCodePro(color: Colors.cyan),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: ressurection,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    decoration: InputDecoration(
                      labelText: "Ressurection Bound",
                      alignLabelWithHint: true,
                      labelStyle: GoogleFonts.sourceCodePro(
                          fontSize: 15,
                          color: Colors.cyan,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.w400),
                      floatingLabelStyle:
                          GoogleFonts.sourceCodePro(color: Colors.cyan),
                      hintStyle: GoogleFonts.sourceCodePro(
                          color: Colors.cyan, fontSize: 14),
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
                    validator: _validateRule,
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
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
                child: Text("Cancel", style: GoogleFonts.sourceCodePro()),
              ),
              ElevatedButton(
                onPressed: () {
                  //confirm
                  if (formKey.currentState!.validate()) {
                    //passing data back, it is valid
                    Navigator.pop(context, [
                      int.parse(lower_bound.text),
                      int.parse(upper_bound.text),
                      int.parse(ressurection.text)
                    ]);
                  }
                },
                child: Text("Confirm", style: GoogleFonts.sourceCodePro()),
              ),
            ],
          );
        });
  }

  static String? _validateRule(value) {
    try {
      int lb = int.parse(value!);
      if (lb > 8 || lb < 1) {
        return "1-8 values only!";
      }
    } catch (_) {
      return "Invalid input!";
    }
    return null;
  }
}
