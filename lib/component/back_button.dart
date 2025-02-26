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
                // SizedBox(width: ,),
                Text("Back")
              ],
            ),
            //  Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(50),
            //     border: Border.all(
            //       width: 2.0,
            //       color: const Color.fromARGB(255, 195, 195, 195),
            //     ),
            //     color: const Color.fromARGB(255, 217, 219, 220),
            //   ),
            //   height: 30,
            //   width: 30,
            //   child:
            // ),
          ),
          //  Image.asset(
          //   "assets/icons/arrow.png",
          //   fit: BoxFit.contain,
          // ),
        ),
      ),
    ),
  );
}
