import 'dart:io';
import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';
import 'package:quran_pak_app/configs/app.dart';
import 'package:quran_pak_app/configs/app_dimensions.dart';
import 'package:quran_pak_app/configs/app_theme.dart';
import 'package:quran_pak_app/configs/space.dart';
import 'package:quran_pak_app/providers/app_provider.dart';
import 'package:quran_pak_app/screens/home/widgets/main_screen.dart';
import 'package:quran_pak_app/utils/drawer.dart';
import 'package:quran_pak_app/widgets/app/app_version.dart';
import 'package:quran_pak_app/widgets/app/drawer_app_name.dart';
part 'widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  final double maxSlide;
  const HomeScreen({Key? key, required this.maxSlide}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 250));
  }

  void toggle() => animationController.isDismissed
      ? animationController.forward()
      : animationController.reverse();

  late bool _canBeDragged;

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    bool isDragOpenFromLeft = animationController.isDismissed;
    bool isDragCloseFromRight = animationController.isCompleted;
    _canBeDragged = isDragOpenFromLeft || isDragCloseFromRight;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    if (_canBeDragged) {
      double delta = details.primaryDelta! / widget.maxSlide;
      animationController.value += delta;
    }
  }

  void _onDragEnd(DragEndDetails details) {
    double kMinFlingVelocity = 365.0;

    if (animationController.isDismissed || animationController.isCompleted) {
      return;
    }
    if (details.velocity.pixelsPerSecond.dx.abs() >= kMinFlingVelocity) {
      double visualVelocity = details.velocity.pixelsPerSecond.dx /
          MediaQuery.of(context).size.width;

      animationController.fling(velocity: visualVelocity);
    } else if (animationController.value < 0.5) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  Future<bool> _onWillPop() async {
    return (await (showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: const Text(
              "Exit Application",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: const Text("Are You Sure?"),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  "No",
                  style: TextStyle(color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text(
                  "Yes",
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
                  exit(0);
                },
              ),
            ],
          ),
        ) as FutureOr<bool>?)) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final appProvider = Provider.of<AppProvider>(context);
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: GestureDetector(
        onHorizontalDragStart: _onDragStart,
        onHorizontalDragUpdate: _onDragUpdate,
        onHorizontalDragEnd: _onDragEnd,
        behavior: HitTestBehavior.translucent,
        child: AnimatedBuilder(
          animation: animationController,
          builder: (context, _) {
            return Material(
              color: appProvider.isDark ? Colors.grey[900] : Colors.grey[200],
              child: Stack(
                children: <Widget>[
                  Transform.translate(
                    offset: Offset(
                        widget.maxSlide * (animationController.value - 1), 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(
                            math.pi / 2 * (1 - animationController.value)),
                      alignment: Alignment.centerRight,
                      child: const _CustomDrawer(),
                    ),
                  ),
                  Transform.translate(
                    offset:
                        Offset(widget.maxSlide * animationController.value, 0),
                    child: Transform(
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, 0.001)
                        ..rotateY(-math.pi / 2 * animationController.value),
                      alignment: Alignment.centerLeft,
                      child: const MainScreen(),
                    ),
                  ),
                  Positioned(
                    top: 4.0 + MediaQuery.of(context).padding.top,
                    left: width * 0.02 +
                        animationController.value * widget.maxSlide,
                    child: IconButton(
                      icon: Icon(
                        Icons.menu_outlined,
                        size: AppDimensions.normalize(11),
                        color: Colors.grey,
                      ),
                      onPressed: toggle,
                      color: appProvider.isDark ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
