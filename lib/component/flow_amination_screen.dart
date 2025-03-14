import 'package:flutter/material.dart';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:signalwavex/component/color.dart';
import 'package:signalwavex/component/fancy_container_two.dart';
import 'package:signalwavex/component/fansycontainer.dart';
import 'package:signalwavex/helpers/helper_functions/helper_functions.dart';

class FlowWidget extends StatefulWidget {
  FlowWidgetController? flowWidgetController;
  FlowWidget({super.key, this.flowWidgetController}) {
    flowWidgetController ??= defaultWidgetController;
  }

  @override
  State<FlowWidget> createState() => _FlowWidgetState();
}

class _FlowWidgetState extends State<FlowWidget> with TickerProviderStateMixin {
  // late AnimationController lineController;
  // late AnimationController popController;

  @override
  void initState() {
    widget.flowWidgetController!.initialise(this, () {
      if (mounted) {
        setState(() {});
      }
    });

    super.initState();
  }

  String debug = '';
  @override
  Widget build(BuildContext context) {
    return Row(
        children: widget.flowWidgetController!.listOfController.map(
      (headTailWidgetController) {
        if (headTailWidgetController.isEnded) {
          return HeadTailWidget(
            headTailWidgetController: headTailWidgetController,
          );
        }
        return Expanded(
          child: HeadTailWidget(
            headTailWidgetController: headTailWidgetController,
          ),
        );
      },
    ).toList());
  }
}

class HeadTailWidget extends StatefulWidget {
  final HeadTailWidgetController headTailWidgetController;

  const HeadTailWidget({super.key, required this.headTailWidgetController});

  @override
  State<HeadTailWidget> createState() => _HeadTailWidgetState();
}

class _HeadTailWidgetState extends State<HeadTailWidget>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _buildHeadTailWidget();
  }

  Container _buildHeadTailWidget() {
    return Container(
      // color: Colors.green,
      height: widget.headTailWidgetController.headerSize,
      child: Stack(
        children: [
          if (widget.headTailWidgetController.isTailVisible)
            Container(
              // color: Colors.blue,
              child: Center(
                child: Row(
                  children: [
                    widget.headTailWidgetController.isEnded
                        ? _buildLine()
                        : Expanded(child: _buildLine())
                    // _buildLine()
                  ],
                ),
              ),
            ),
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              // color: Colors.green,
              child: _buildHead(),
            ),
          )
        ],
      ),
    );
  }

  Container _buildHead() {
    return Container(
      // color: Colors.purple,
      height: widget.headTailWidgetController.headerSize,
      width: widget.headTailWidgetController.headerSize,
      child: widget.headTailWidgetController.isEnded
          ? FittedBox(
              child: widget.headTailWidgetController.popBackgroundWidget ??
                  FancyContainerTwo(
                    radius: 40,
                    height:
                        widget.headTailWidgetController.headerSize ?? 0 + 10,
                    width: widget.headTailWidgetController.headerSize ?? 0 + 10,
                    backgroundColor: widget.headTailWidgetController.topColor ??
                        ColorConstants.fancyGreen,
                    padding: const EdgeInsets.all(1),
                    child:
                        widget.headTailWidgetController.popBackgroundWidget ??
                            Image.asset(
                              "assets/icons/flowIcon1Highlighted.png",
                            ),
                  ),
            )
          : FittedBox(
              child: Stack(
                children: [
                  Center(
                    child: widget
                            .headTailWidgetController.popBackgroundWidget ??
                        FancyContainerTwo(
                          radius: 40,
                          height: widget.headTailWidgetController.headerSize ??
                              0 - 5,
                          width: widget.headTailWidgetController.headerSize ??
                              0 - 5,
                          padding: const EdgeInsets.all(10),
                          child: widget.headTailWidgetController
                                  .popBackgroundWidget ??
                              Image.asset(
                                "assets/icons/flowIcon1Unhighlighted.png",
                              ),
                        ),
                  ),
                  widget.headTailWidgetController.popLabel ??
                      FancyContainerTwo(
                        radius: 40,
                        height: widget.headTailWidgetController.headerSize ??
                            0 + 10,
                        width: widget.headTailWidgetController.headerSize ??
                            0 + 10,
                        // backgroundColor:
                        //     widget.headTailWidgetController.backgroundColor ??
                        //         ColorConstants.fancyGreen,
                        padding: const EdgeInsets.all(15),
                        child: widget
                                .headTailWidgetController.popBackgroundWidget ??
                            Image.asset(
                              "assets/icons/flowIcon1Highlighted.png",
                            ),
                      )
                          .animate(
                              autoPlay: false,
                              onComplete: (controller) {
                                // controller.repeat();
                              },
                              controller: widget.headTailWidgetController
                                  .headAnimationController)
                          .scale(
                            begin: const Offset(0, 0),
                            curve: Curves.bounceOut,
                            // duration: const Duration(seconds: 1)
                          ),
                ],
              ),
            ),
    );
  }

  SizedBox _buildLine() {
    return SizedBox(
      height: 3,
      child: Stack(
        children: [
          FancyContainerTwo(
            width: double.infinity,
            height: double.infinity,
            radius: 3,
            backgroundColor: widget.headTailWidgetController.backgroundColor ??
                getFigmaColor("EBEAEA"),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: FancyContainerTwo(
              width: double.infinity,
              height: double.infinity,
              radius: 3,
              backgroundColor: widget.headTailWidgetController.topColor ??
                  ColorConstants.fancyGreen,
            )
                .animate(
                    autoPlay: false,
                    onComplete: (controller) {
                      // controller.repeat();
                    },
                    controller:
                        widget.headTailWidgetController.tailAnimationController)
                .scaleX(
                    begin: 0,
                    // duration: const Duration(seconds: 1),
                    alignment: Alignment.centerLeft),
          )
        ],
      ),
    );
  }
}

class FlowWidgetController {
  final List<HeadTailWidgetController> listOfController;
  Function stateUpdaterFucntion = () {};
  late HeadTailWidgetController currentController;

  FlowWidgetController({
    required this.listOfController,
  }) {
    currentController = listOfController.elementAt(currentIndex);
  }
  Future initialise(
      TickerProviderStateMixin state, Function stateUpdater) async {
    stateUpdaterFucntion = stateUpdater;
    for (HeadTailWidgetController headTailWidgetController
        in listOfController) {
      await headTailWidgetController.initialize(state);
    }
  }

  int currentIndex = 0;
  Future nextPage() async {
    if (currentIndex <= listOfController.length - 1) {
      if (listOfController.last != currentController) {
        currentController = listOfController[currentIndex + 1];
        currentIndex += 1;
      }
      await currentController.animateForward();
    }
    stateUpdaterFucntion.call();
  }

  Future previousPage() async {
    if (listOfController.first != currentController) {
      await currentController.animateBackward();
      currentIndex -= 1;
      currentController = listOfController[currentIndex];
    }
    stateUpdaterFucntion.call();
  }

  gotoIndex(int index) async {
    for (var i = currentIndex; i < index; i++) {
      await nextPage();
      stateUpdaterFucntion.call();
    }
    for (var i = currentIndex; i > index; i--) {
      await previousPage();
      stateUpdaterFucntion.call();
    }
    currentIndex = index;
    // if (currentIndex < index) {
    //   for
    // }
  }

  dispose() {}
}

// class FlowWidgetModel {}

class HeadTailWidgetController {
  AnimationController? tailAnimationController;
  AnimationController? headAnimationController;
  Color? topColor;
  Color? backgroundColor;
  Widget? popContainer;
  Widget? popBackgroundWidget;
  Widget? popLabel;
  Widget? popbgLabel;
  double? headerSize;

  double? tailHeight;
  bool isEnded;

  bool isTailVisible = true;
  HeadTailWidgetController({
    this.tailAnimationController,
    this.headAnimationController,
    this.topColor,
    this.backgroundColor,
    this.popContainer,
    this.popBackgroundWidget,
    this.popLabel,
    this.popbgLabel,
    this.tailHeight,
    this.isTailVisible = true,
    this.isEnded = false,
    this.headerSize = 20,
  }) {
// if (widget.headTailWidgetController.isTailVisible??false)
// headerSize
  }
  Direction direction = Direction.forward;

  initialize(TickerProviderStateMixin state) {
    tailAnimationController ??=
        AnimationController(vsync: state, duration: .5.seconds);
    headAnimationController ??=
        AnimationController(vsync: state, duration: .5.seconds);

    tailAnimationController!.addListener(
      () {
        if (tailAnimationController!.isCompleted) {
          direction;
          if (direction == Direction.forward) {
            headAnimationController!.reset();
            headAnimationController!.forward();
          } else {
            headAnimationController!.reverse();
          }
        }
      },
    );
  }

  Future animateForward() async {
    direction = Direction.forward;
    if (isTailVisible) {
      print("isTailVisible");
      await tailAnimationController?.forward();
    } else {
      await headAnimationController?.forward();
    }
  }

  Future animateBackward() async {
    direction = Direction.reverse;
    await headAnimationController?.reverse();
    if (isTailVisible) {
      await tailAnimationController?.reverse();
    }
    // else {

    // }
  }
}

FlowWidgetController defaultWidgetController =
    FlowWidgetController(listOfController: [
  HeadTailWidgetController(
    backgroundColor: bgColor,
    popbgLabel: FancyContainerTwo(
      hasBorder: true,
      borderColor: Colors.white,
      borderThickness: 2,
      height: 20,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      width: 20,
      radius: 40,
    ),
    popLabel: const SizedBox(),
    popBackgroundWidget: FancyContainerTwo(
      hasBorder: true,
      borderColor: Colors.grey,
      borderThickness: 2,
      height: 20,
      width: 20,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      radius: 40,
    ),
    isTailVisible: false,
    isEnded: true,
    headerSize: headerSize,
  ),
  HeadTailWidgetController(
    popbgLabel: FancyContainerTwo(
      hasBorder: true,
      borderColor: Colors.white,
      borderThickness: 5,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      height: 20,
      width: 20,
      radius: 40,
    ),
    popLabel: const SizedBox(),
    backgroundColor: bgColor,
    //  getFigmaColor("383838"),
    popBackgroundWidget: FancyContainerTwo(
      hasBorder: true,
      borderColor: bgColor,
      borderThickness: 3,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      height: 20,
      width: 20,
      radius: 40,
    ),
    headerSize: headerSize,
    isTailVisible: true,
    isEnded: false,
  ),
  HeadTailWidgetController(
    backgroundColor: bgColor,
    popbgLabel: FancyContainerTwo(
      hasBorder: true,
      borderColor: Colors.white,
      borderThickness: 5,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      height: 20,
      width: 20,
      radius: 40,
    ),
    headerSize: headerSize,
    popLabel: const SizedBox(),
    popBackgroundWidget: FancyContainerTwo(
      hasBorder: true,
      borderColor: bgColor,
      borderThickness: 3,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      height: 20,
      width: 20,
      radius: 40,
    ),
    isTailVisible: true,
    isEnded: false,
  ),
  HeadTailWidgetController(
    backgroundColor: bgColor,
    popbgLabel: FancyContainerTwo(
      hasBorder: true,
      borderColor: Colors.white,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      borderThickness: 5,
      height: 20,
      width: 20,
      radius: 40,
    ),
    popLabel: const SizedBox(),
    popBackgroundWidget: FancyContainerTwo(
      hasBorder: true,
      borderColor: bgColor,
      borderThickness: 3,
      backgroundColor: const Color.fromARGB(255, 21, 21, 21),
      height: 20,
      width: 20,
      radius: 40,
    ),
    isTailVisible: true,
    isEnded: false,
    headerSize: headerSize,
  ),
]);

double headerSize = 10;
Color bgColor = getFigmaColor("383838");
