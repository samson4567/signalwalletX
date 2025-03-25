import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FancyContainerTwo extends StatefulWidget {
  Widget? child;
  double? radius;
  Color? backgroundColor;
  Color? borderColor;
  double? borderThickness;
  bool? hasBorder;
  double? height;
  double? width;
  List<BoxShadow> shadows = [];
  Function()? action;
  EdgeInsets? padding;
  final Alignment? alignment;
  final bool? isAsync;
  final bool? nulledAlign;
  final BoxConstraints? constraints;
  BorderRadius? borderRadius;

  // noAli
  FancyContainerTwo({
    super.key,
    this.child,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.hasBorder,
    this.height,
    this.width,
    this.action,
    this.shadows = const [],
    this.padding,
    this.alignment,
    this.isAsync = false,
    this.constraints,
    this.nulledAlign,
    this.borderThickness,
    this.borderRadius,
  });

  @override
  State<FancyContainerTwo> createState() => _FancyContainerTwoState();
}

class _FancyContainerTwoState extends State<FancyContainerTwo> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    widget.hasBorder ??= false;
    widget.borderColor ??= const Color(0xFF000000);
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
            child: Container(
              constraints: widget.constraints,
              clipBehavior: Clip.hardEdge,
              padding: widget.padding,
              alignment: (widget.nulledAlign ?? false)
                  ? null
                  : widget.alignment ?? Alignment.center,
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                boxShadow: widget.shadows,
                borderRadius: widget.borderRadius ??
                    BorderRadius.circular(widget.radius ?? 8),
                color: widget.backgroundColor,
                border: widget.hasBorder!
                    ? Border.all(
                        color: widget.borderColor ?? const Color(0xFF000000),
                        width: widget.borderThickness ?? 1,
                      )
                    : null,
              ),
              child: widget.child,
            ),
          )
        : Container(
            width: widget.width,
            height: widget.height,
            child: const Center(
              child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator.adaptive()),
            ),
          );
  }
}
