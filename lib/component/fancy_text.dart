import 'package:flutter/material.dart';

class FancyText extends StatefulWidget {
  // Widget? child;
  // double? radius;
  // Color? backgroundColor;
  // Color? borderColor;
  // double? borderThickness;
  // bool? hasBorder;
  // double? height;
  // double? width;
  // List<BoxShadow> shadows = [];
  // Function()? action;
  // EdgeInsets? padding;
  // final Alignment? alignment;
  // final bool? isAsync;
  // final bool? nulledAlign;
  // final BoxConstraints? constraints;
  // BorderRadius? borderRadius;
  String text;
  final Color? textColor;
  final double? size;
  final FontWeight? weight;
  final TextAlign? textAlign;
  final TextStyle? rawTextStyle;
  final Function()? action;
  final bool? isAsync;

  // noAli
  FancyText(
    this.text, {
    super.key,
    this.textColor,
    this.size,
    this.weight,
    this.textAlign,
    this.rawTextStyle,
    this.action,
    this.isAsync,
  });

  @override
  State<FancyText> createState() => _FancyTextState();
}

class _FancyTextState extends State<FancyText> {
  bool isLoading = false;
  TextStyle textStyle = TextStyle();

  @override
  Widget build(BuildContext context) {
    textStyle = TextStyle(
      color: widget.textColor,
      fontSize: widget.size,
      fontWeight: widget.weight,
    );

    // widget.hasBorder ??= false;
    // widget.borderColor ??= const Color(0xFF000000);
    return !isLoading
        ? GestureDetector(
            onTap: (widget.action != null)
                ? (widget.isAsync ?? true)
                    ? () async {
                        isLoading = true;
                        if (mounted) setState(() {});
                        await Future.delayed(const Duration(seconds: 1));
                        await widget.action?.call();
                        isLoading = false;
                        if (mounted) setState(() {});
                      }
                    : () {
                        widget.action?.call();
                      }
                : null,
            child: Text(
              widget.text,
              style: widget.rawTextStyle ?? textStyle,
              textAlign: widget.textAlign,
            ))
        : Container(
            // width: widget.width,
            // height: widget.height,
            child: const Center(
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive()),
            ),
          );
  }
}
