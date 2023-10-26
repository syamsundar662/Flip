import 'package:flutter/material.dart';

class SlideAnimationWidget extends StatelessWidget {
  const SlideAnimationWidget({
    super.key, required this.slideAnimationWidgetVariable,
  });
  final Widget slideAnimationWidgetVariable;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 1),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          curve: Curves.easeInOut,
          parent: ModalRoute.of(context)?.animation ??
              AnimationController(vsync: ScaffoldState()),
        ),
      ),
      child: slideAnimationWidgetVariable
    );
  }
}
