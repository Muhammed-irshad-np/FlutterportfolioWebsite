import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:myportfolio/viewmodels/homeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart';

class HomepageView extends StatefulWidget {
  const HomepageView({super.key});

  @override
  State<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends State<HomepageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withGreen(10),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            topMargin(),
            leftMargin(context),
            rightMargin(context),
            bottomMargin(context),
          ],
        ),
      ),
    );
  }

  Align bottomMargin(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(4),
                bottomRight: Radius.circular(4)),
            border: Border(
                bottom:
                    BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
                top: BorderSide(
                    color: Colors.white.withOpacity(0.3), width: 1))),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Consumer<HomeViewModel>(
                  builder: (context, viewmodel, child) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 0),
                      child: GestureDetector(
                        onTap: () {
                          viewmodel.updateToggleButton();
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: SizedBox(
                            height: 50,
                            width: 40,
                            child: UnconstrainedBox(
                              child: AnimatedContainer(
                                width: 8,
                                height: 8,
                                duration: const Duration(seconds: 1),
                                decoration: BoxDecoration(
                                  color: viewmodel.toggleOnlineButton
                                      ? const Color.fromARGB(255, 140, 255, 117)
                                      : const Color.fromARGB(255, 119, 185, 106)
                                          .withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                curve: Curves.easeInOut,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Consumer<HomeViewModel>(
                        builder: (context, viewmodel, child) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (event) {
                              viewmodel.isLoacationHovered(true);
                            },
                            onExit: (event) {
                              viewmodel.isLoacationHovered(false);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Based in ",
                                  style: TextStyle(
                                      fontFamily: "NeuMachina",
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 2),
                                  child: AnimatedDefaultTextStyle(
                                    duration: const Duration(milliseconds: 400),
                                    style: TextStyle(
                                        fontFamily: "NeuMachina",
                                        fontSize: 14,
                                        color: viewmodel.islocationhovered
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                        fontWeight: FontWeight.w500),
                                    child: const Text(
                                      "India",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeIn,
                            // transform: viewmodel.islocationhovered
                            //     ? Matrix4.translationValues(0, 0, 0)
                            //     : Matrix4.translationValues(10, 0, 0),
                            width: viewmodel.islocationhovered ? 40 : 0,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                " Kerala",
                                style: TextStyle(
                                  fontFamily: "NeuMachina",
                                  fontSize: 10,
                                  color: Colors.white.withOpacity(0.5),
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          MouseRegion(
                            cursor: SystemMouseCursors.click,
                            onEnter: (event) {
                              viewmodel.updateTimeHover(true);
                            },
                            onExit: (event) {
                              viewmodel.updateTimeHover(false);
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Local time ",
                                  style: TextStyle(
                                      fontFamily: "NeuMachina",
                                      fontSize: 14,
                                      color: Colors.white.withOpacity(0.5),
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 2),
                                  child: AnimatedDefaultTextStyle(
                                    style: TextStyle(
                                        fontFamily: "NeuMachina",
                                        fontSize: 14,
                                        color: viewmodel.istimehover
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                        fontWeight: FontWeight.w500),
                                    duration: const Duration(milliseconds: 400),
                                    child: Text(
                                      viewmodel.currentTime,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                )
              ],
            )),
      ),
    );
  }

  Align rightMargin(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Container(
        width: 1,
        height: MediaQuery.of(context).size.height - 50,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white.withOpacity(0.3), width: 1)),
      ),
    );
  }

  Container leftMargin(BuildContext context) {
    return Container(
      width: 40,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
          border: Border(
            right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
            left: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
          )),
      child: leftMenubar(),
    );
  }

  Column leftMenubar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          size: 20,
          Icons.home_outlined,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          height: 13,
        ),
        Icon(
          size: 20,
          Icons.person_outline,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          height: 13,
        ),
        Icon(
          Icons.laptop_chromebook_outlined,
          size: 17,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          height: 13,
        ),
        Icon(
          size: 22,
          Icons.bolt_outlined,
          color: Colors.white.withOpacity(0.4),
        ),
        const SizedBox(
          height: 13,
        ),
        Icon(
          color: Colors.white.withOpacity(0.4),
          Icons.mail_outline,
          size: 18,
        )
      ],
    );
  }

  Container topMargin() {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4), topRight: Radius.circular(4)),
          border: Border(
            bottom: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
            right: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
            top: BorderSide(color: Colors.white.withOpacity(0.3), width: 1),
          )),
      child: Padding(
        padding: const EdgeInsets.only(left: 5),
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                height: 30,
                width: 30,
                child: Stack(
                  children: [
                    // Positioned(
                    //   top: 4.5,
                    //   left: 2,
                    //   child: ClipRect(
                    //     child: Transform.rotate(
                    //       angle: 15 * pi / 180,
                    //       child: Image.asset(
                    //         "assets/slash.png",
                    //         width: 24,
                    //         height: 19,
                    //         color: Colors.white,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // RotatedBox(
                    //   quarterTurns: 1,
                    //   child: Image.asset(
                    //     width: 28,
                    //     height: 28,
                    //     "assets/codeview.png",
                    //     color: Colors.white,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 5, left: 55),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: const TextSpan(
                    style: TextStyle(
                      fontFamily: "NeuMachina",
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    children: [
                      TextSpan(
                        text: "muhammed",
                      ),
                      TextSpan(
                        text: "<irshad>",
                        style: TextStyle(
                          fontFamily: "NeuMachina",
                          fontSize: 16,
                          color: Colors.green,
                          fontWeight: FontWeight.w400,

                          // Any additional styles specific to "<Irshad>"
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Row(
              children: [
                Icon(
                  Icons.remove,
                  color: Colors.white.withOpacity(0.3),
                  size: 15,
                ),
                const SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.white.withOpacity(0.3),
                  size: 15,
                ),
                SizedBox(
                  width: 8,
                ),
                Icon(
                  Icons.close,
                  color: Colors.white.withOpacity(0.3),
                  size: 15,
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
