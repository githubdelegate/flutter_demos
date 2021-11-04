import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AnimationImage extends AnimatedWidget {
  AnimationImage({Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final ani = listenable as Animation<double>;
    return Center(
        child: Image.asset(
      'images/image.jpg',
      width: ani.value,
      height: ani.value,
    ));
  }
}

class ScaleAnimationRoute extends StatefulWidget {
  ScaleAnimationRoute({Key? key}) : super(key: key);

  @override
  _ScaleAnimationRouteState createState() => _ScaleAnimationRouteState();
}

class _ScaleAnimationRouteState extends State<ScaleAnimationRoute>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);
    animation = Tween(begin: 0.0, end: 500.0).animate(animation)
      ..addListener(() {
        setState(() {});
      });

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: Image.asset("images/image.jpg",
    //       width: animation.value, height: animation.value),
    // );

    // return AnimationImage(animation: animation);

    // return SizeTransition(
    // sizeFactor: animation, child: Image.asset("images/image.jpg"));
    return GrowTransition(
        animation: animation, child: Image.asset("images/image.jpg"));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class GrowTransition extends StatelessWidget {
  const GrowTransition({Key? key, required this.animation, this.child});
  final Animation<double> animation;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: animation,
        builder: (BuildContext ctx, child) {
          return SizedBox(
            height: animation.value,
            width: animation.value,
            child: child,
          );
        },
        child: child,
      ),
    );
    // return SizedBox(
    //   child: child,
    //   height: ani.value,
    //   width: ani.value,
    // );
  }
}
