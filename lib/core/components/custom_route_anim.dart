import 'package:flutter/material.dart';

class StandardUniversalAnimations extends PageRouteBuilder {
  final Widget child;
  final int milliSecondsToShow;
  final int milliSecondsToClose;

  /// Будет Работать только с типом CustomAnimationType.sizeTransition
  final AlignmentGeometry alignment;

  /// Будет Работать только с типом CustomAnimationType.sizeTransition
  final Color sizeColor;

  StandardUniversalAnimations({
    required this.child,
    this.milliSecondsToShow = 500,
    this.milliSecondsToClose = 500,
    RouteSettings? settings,
    this.alignment = Alignment.center,
    this.sizeColor = Colors.transparent,
  }) : super(
          transitionDuration: Duration(milliseconds: milliSecondsToShow),
          reverseTransitionDuration:
              Duration(milliseconds: milliSecondsToClose),
          pageBuilder: (context, animation, secondaryAnimation) => child,
          settings: settings,
        );

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
