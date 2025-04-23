import 'package:flutter/material.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';

class RadioButton extends StatefulWidget {
  final String text;
  final double? radius;
  final bool isHignlighted;
  final EdgeInsets? padding;

  final Function(String text) onclick;

  const RadioButton({
    super.key,
    required this.text,
    required this.onclick,
    required this.isHignlighted,
    required this.radius,
    this.padding,
  });

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  bool isSelected = false;
  @override
  void initState() {
    isSelected = widget.isHignlighted;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isSelected = widget.isHignlighted;
    return GestureDetector(
      onTap: () {
        // isSelected = !isSelected;
        // widget.isHignlighted=!widget.isHignlighted
        widget.onclick.call(widget.text);
        setState(() {});
      },
      child: Container(
        // alignment: Alignment.center,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: (!widget.isHignlighted)
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius ?? 50),
                // border: Border.all(color: Colors.white),
                color: Colors.grey.withAlpha(30),
              )
            : BoxDecoration(
                borderRadius: BorderRadius.circular(widget.radius ?? 50),
                // border: Border.all(color: Colors.white),
                color: getFigmaColor("3D5AF1")),

        child: Text(
          widget.text,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.white,
            // .withOpacity(.56),
          ),
        ),
      ),
    );
  }
}
