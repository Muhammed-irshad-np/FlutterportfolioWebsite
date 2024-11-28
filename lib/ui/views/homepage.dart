import 'dart:developer';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:myportfolio/ui/widgets/project_card.dart';
import 'package:myportfolio/ui/widgets/testimonial_card.dart';
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
  Offset aboutMePosition = Offset(0, 0);
  Offset whereIWorkPosition = Offset(50, 100);
  Offset hobbiesPosition = Offset(200, 200);
  Offset socialPosition = Offset(400, 50);
  Offset dragOffset = Offset(0, 0);

  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(
          children: [
            // Margins stay fixed
            topMargin(),
            leftMargin(context),
            rightMargin(context),
            bottomMargin(context),

            // Scrollable content inside the margins
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 40, // Left margin width
                  top: 40, // Top margin height
                  bottom: 40, // Bottom margin height
                  right: 0,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // First section
                      SizedBox(
                        height: MediaQuery.of(context).size.height -
                            80, // Subtract margins
                        child: mainContent(),
                      ),

                      // Second section
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            "Your creative web developer",
                            style: TextStyle(
                              fontSize: 64,
                              color: Colors.white,
                              fontFamily: "NeuMachina",
                              height: 1.1,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            height: 1000,
                            width: double.infinity,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Positioned(
                                  left: aboutMePosition.dx,
                                  top: aboutMePosition.dy,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Draggable(
                                      feedback: aboutMeBox(),
                                      childWhenDragging: Container(),
                                      dragAnchorStrategy:
                                          pointerDragAnchorStrategy,
                                      feedbackOffset: Offset.zero,
                                      onDragEnd: (details) {
                                        setState(() {
                                          aboutMePosition = Offset(
                                            details.offset.dx,
                                            details.offset.dy,
                                          );
                                        });
                                      },
                                      child: aboutMeBox(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: whereIWorkPosition.dx,
                                  top: whereIWorkPosition.dy,
                                  child: GestureDetector(
                                    onTapDown: (_) {},
                                    onTapUp: (_) {},
                                    onTap: () {},
                                    child: Draggable(
                                      feedback: whereIWorkBox(),
                                      childWhenDragging: Container(),
                                      dragAnchorStrategy:
                                          pointerDragAnchorStrategy,
                                      feedbackOffset: Offset.zero,
                                      onDragStarted: () {
                                        RenderBox renderBox = context
                                            .findRenderObject() as RenderBox;
                                        final position = renderBox
                                            .localToGlobal(Offset.zero);
                                        dragOffset = Offset(
                                          position.dx - whereIWorkPosition.dx,
                                          position.dy - whereIWorkPosition.dy,
                                        );
                                      },
                                      onDragUpdate: (details) {
                                        setState(() {
                                          RenderBox renderBox = context
                                              .findRenderObject() as RenderBox;
                                          var localPosition =
                                              renderBox.globalToLocal(
                                                  details.globalPosition);
                                          whereIWorkPosition = Offset(
                                            localPosition.dx - dragOffset.dx,
                                            localPosition.dy - dragOffset.dy,
                                          );
                                        });
                                      },
                                      child: whereIWorkBox(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: hobbiesPosition.dx,
                                  top: hobbiesPosition.dy,
                                  child: GestureDetector(
                                    onTapDown: (_) {},
                                    onTapUp: (_) {},
                                    onTap: () {},
                                    child: Draggable(
                                      feedback: hobbiesBox(),
                                      childWhenDragging: Container(),
                                      dragAnchorStrategy:
                                          pointerDragAnchorStrategy,
                                      feedbackOffset: Offset.zero,
                                      onDragUpdate: (details) {
                                        setState(() {
                                          RenderBox renderBox = context
                                              .findRenderObject() as RenderBox;
                                          var localPosition =
                                              renderBox.globalToLocal(
                                                  details.globalPosition);
                                          hobbiesPosition = localPosition;
                                        });
                                      },
                                      child: hobbiesBox(),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: socialPosition.dx,
                                  top: socialPosition.dy,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: Draggable(
                                      feedback: socialBox(),
                                      childWhenDragging: Container(),
                                      dragAnchorStrategy:
                                          pointerDragAnchorStrategy,
                                      feedbackOffset: Offset.zero,
                                      onDragEnd: (details) {
                                        setState(() {
                                          socialPosition = Offset(
                                            details.offset.dx,
                                            details.offset.dy,
                                          );
                                        });
                                      },
                                      child: socialBox(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 40),
                          Consumer<HomeViewModel>(
                            builder: (context, viewModel, _) => MouseRegion(
                              cursor: SystemMouseCursors.click,
                              onEnter: (_) =>
                                  viewModel.setAboutButtonHover(true),
                              onExit: (_) =>
                                  viewModel.setAboutButtonHover(false),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 16),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.3),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    // Animated background
                                    Positioned.fill(
                                      child: AnimatedOpacity(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        opacity: viewModel.isAboutButtonHovered
                                            ? 1.0
                                            : 0.0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF4ADE80)
                                                .withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                        )
                                            .animate(
                                              target:
                                                  viewModel.isAboutButtonHovered
                                                      ? 1.0
                                                      : 0.0,
                                            )
                                            .shimmer(
                                              duration:
                                                  const Duration(seconds: 2),
                                              color: const Color(0xFF4ADE80)
                                                  .withOpacity(0.3),
                                            )
                                            .fade(
                                              duration: const Duration(
                                                  milliseconds: 300),
                                            ),
                                      ),
                                    ),
                                    // Button content
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'about—me',
                                          style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            fontSize: 16,
                                            fontFamily: "NeuMachina",
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        AnimatedContainer(
                                          duration:
                                              const Duration(milliseconds: 300),
                                          transform: Matrix4.translationValues(
                                            viewModel.isAboutButtonHovered
                                                ? 4.0
                                                : 0.0,
                                            0.0,
                                            0.0,
                                          ),
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color:
                                                Colors.white.withOpacity(0.7),
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 200),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // Projects Highlight Section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Projects ",
                                        style: TextStyle(
                                          fontSize: 64,
                                          color: Colors.white,
                                          fontFamily: "NeuMachina",
                                          height: 1.1,
                                        ),
                                      ),
                                      Text(
                                        "highlight",
                                        style: TextStyle(
                                          fontSize: 64,
                                          color: const Color(0xFF4ADE80),
                                          fontFamily: "NeuMachina",
                                          height: 1.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  // Project cards here
                                  ProjectCard(
                                    number: "01",
                                    title: "Lorenzo Bocchi",
                                    year: "2023",
                                    tags: [
                                      "webflow",
                                      "gsap",
                                      "javascript",
                                      "css"
                                    ],
                                    works: 1,
                                    awards: 4,
                                  ),
                                  const SizedBox(height: 200),
                                ],
                              ),

                              // Nice things people say section
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Nice things ",
                                    style: TextStyle(
                                      fontSize: 64,
                                      color: Colors.white,
                                      fontFamily: "NeuMachina",
                                      height: 1.1,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "people say ",
                                        style: TextStyle(
                                          fontSize: 64,
                                          color: const Color(0xFF4ADE80),
                                          fontFamily: "NeuMachina",
                                          height: 1.1,
                                        ),
                                      ),
                                      Text(
                                        "about my work",
                                        style: TextStyle(
                                          fontSize: 64,
                                          color: Colors.white,
                                          fontFamily: "NeuMachina",
                                          height: 1.1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 40),
                                  // Testimonial cards here
                                  TestimonialCard(),
                                  const SizedBox(height: 200),
                                ],
                              ),

                              // Let's work together section
                              Container(
                                padding: const EdgeInsets.all(40),
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: Colors.white.withOpacity(0.1),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 30,
                                          backgroundColor:
                                              const Color(0xFF4ADE80),
                                          child: Icon(Icons.waving_hand,
                                              color: Colors.white),
                                        ),
                                        const SizedBox(width: 20),
                                        Expanded(
                                          child: Text(
                                            "Let's work together on your next project",
                                            style: TextStyle(
                                              fontSize: 48,
                                              color: Colors.white,
                                              fontFamily: "NeuMachina",
                                              height: 1.1,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 40),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFF4ADE80),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      child: Text(
                                        "let's-get-in-touch",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontFamily: "NeuMachina",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 200),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget mainContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text(
                "Hi, I'm Muhammed, a",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 64,
                  color: Colors.white,
                  fontFamily: "NeuMachina",
                  height: 1.1,
                ),
              ),
              Text(
                "creative developer",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 64,
                  color: const Color(0xFF4ADE80),
                  fontFamily: "NeuMachina",
                  height: 1.1,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                "I bring value to web development projects by merging\ntechnical expertise with creativity and aesthetics.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.7),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
      ],
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
                                      "I  ndia",
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
        _buildMenuIcon(Icons.home_outlined),
        _buildMenuIcon(Icons.person_outline),
        _buildMenuIcon(Icons.laptop_chromebook_outlined, size: 17),
        _buildMenuIcon(Icons.bolt_outlined),
        _buildMenuIcon(Icons.mail_outline, size: 18),
      ],
    );
  }

  Widget _buildMenuIcon(IconData icon, {double size = 20}) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, _) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => viewModel.updateIconHover(icon, true),
        onExit: (_) => viewModel.updateIconHover(icon, false),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6.5),
          child: Icon(
            icon,
            size: size,
            color: viewModel.isIconHovered(icon)
                ? Colors.white
                : Colors.white.withOpacity(0.4),
          ),
        ),
      ),
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

  Widget aboutMeBox() {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'about-me',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                // Window controls
                Row(
                  children: [
                    Icon(Icons.remove,
                        size: 16, color: Colors.white.withOpacity(0.7)),
                    const SizedBox(width: 8),
                    Icon(Icons.crop_square,
                        size: 14, color: Colors.white.withOpacity(0.7)),
                    const SizedBox(width: 8),
                    Icon(Icons.close,
                        size: 16, color: Colors.white.withOpacity(0.7)),
                  ],
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white,
                      fontFamily: 'NeuMachina',
                    ),
                    children: [
                      const TextSpan(text: '1  Nice to meet you! I\'m '),
                      TextSpan(
                        text: 'Muhammed',
                        style: TextStyle(color: Colors.green),
                      ),
                      const TextSpan(
                          text: ', I\'m a Freelance Web Developer.\n'),
                      const TextSpan(text: '2  I\'m passionate about both '),
                      TextSpan(
                          text: 'web ', style: TextStyle(color: Colors.blue)),
                      TextSpan(
                          text: 'design ',
                          style: TextStyle(color: Colors.purple)),
                      const TextSpan(text: 'and '),
                      TextSpan(
                          text: 'web ', style: TextStyle(color: Colors.blue)),
                      TextSpan(
                          text: 'development',
                          style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget whereIWorkBox() {
    return Container(
      width: 600,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Text(
                  'where-i-work',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.remove,
                        size: 16, color: Colors.white.withOpacity(0.7)),
                    const SizedBox(width: 8),
                    Icon(Icons.crop_square,
                        size: 14, color: Colors.white.withOpacity(0.7)),
                    const SizedBox(width: 8),
                    Icon(Icons.close,
                        size: 16, color: Colors.white.withOpacity(0.7)),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white,
                      fontFamily: 'NeuMachina',
                    ),
                    children: [
                      const TextSpan(text: '1  Based in '),
                      TextSpan(
                        text: 'Kochi, India',
                        style: TextStyle(color: Colors.green),
                      ),
                      const TextSpan(text: '\n'),
                      const TextSpan(text: '2  '),
                      TextSpan(
                        text: 'Remote collaborations',
                        style: TextStyle(color: Colors.blue),
                      ),
                      const TextSpan(text: ' accepted'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget hobbiesBox() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: MouseRegion(
              child: Row(
                children: [
                  Text(
                    'hobbies',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.remove,
                          size: 16, color: Colors.white.withOpacity(0.7)),
                      const SizedBox(width: 8),
                      Icon(Icons.crop_square,
                          size: 14, color: Colors.white.withOpacity(0.7)),
                      const SizedBox(width: 8),
                      Icon(Icons.close,
                          size: 16, color: Colors.white.withOpacity(0.7)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white,
                      fontFamily: 'NeuMachina',
                    ),
                    children: [
                      TextSpan(
                          text: '1  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Photography',
                          style: TextStyle(color: Colors.blue)),
                      TextSpan(
                          text: '\n2  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Gaming',
                          style: TextStyle(color: Colors.green)),
                      TextSpan(
                          text: '\n3  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Music',
                          style: TextStyle(color: Colors.purple)),
                      TextSpan(
                          text: '\n4  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Traveling',
                          style: TextStyle(color: Colors.orange)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget socialBox() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.white.withOpacity(0.1),
                ),
              ),
            ),
            child: MouseRegion(
              child: Row(
                children: [
                  Text(
                    'me-online',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(Icons.remove,
                          size: 16, color: Colors.white.withOpacity(0.7)),
                      const SizedBox(width: 8),
                      Icon(Icons.crop_square,
                          size: 14, color: Colors.white.withOpacity(0.7)),
                      const SizedBox(width: 8),
                      Icon(Icons.close,
                          size: 16, color: Colors.white.withOpacity(0.7)),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      height: 1.6,
                      color: Colors.white,
                      fontFamily: 'NeuMachina',
                    ),
                    children: [
                      TextSpan(
                          text: '1  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Instagram',
                          style: TextStyle(color: Colors.pink)),
                      TextSpan(
                          text: '\n2  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Twitter',
                          style: TextStyle(color: Colors.blue)),
                      TextSpan(
                          text: '\n3  ', style: TextStyle(color: Colors.grey)),
                      TextSpan(
                          text: 'Facebook',
                          style: TextStyle(color: Colors.indigo)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
