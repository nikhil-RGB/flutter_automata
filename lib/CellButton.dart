// ignore: file_names
import 'package:flutter/material.dart';

import 'models/Cell.dart';

//An object of this class represents a single CellButton in a cell grid
class CellButton extends StatefulWidget {
  final Cell cell;
  final Color live;
  final Color dead;
  const CellButton({
    super.key,
    required this.cell,
    required this.live,
    required this.dead,
  });
  @override
  State<CellButton> createState() => _CellButtonState();
}

class _CellButtonState extends State<CellButton> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          widget.cell.state = !widget.cell.state;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.cell.state ? widget.live : widget.dead,
      ),
      child: const Text(""),
    );
  }
}
