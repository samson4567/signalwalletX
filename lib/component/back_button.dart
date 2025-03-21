import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Widget buildBackArrow(
  BuildContext context, {
  Function()? replaceFunction,
  Function()? supplimentFunctionBefore,
  Function()? supplimentFunctionAfter,
}) {
  return Visibility(
    visible: true,
    //  !(ModalRoute.of(context)?.isFirst ?? true),
    child: Padding(
      padding: const EdgeInsets.only(left: 1.0),
      child: SizedBox(
        height: 40,
        width: 40,
        child: GestureDetector(
          onTap: replaceFunction ??
              () {
                supplimentFunctionBefore?.call();
                context.pop();
                supplimentFunctionAfter?.call();
              },
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.arrow_back_outlined,
                  size: 20,
                ),
                Text("Back")
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
