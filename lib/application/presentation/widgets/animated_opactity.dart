
import 'package:flutter/widgets.dart';

class AnimatedOpacityWidget extends StatelessWidget {
  const AnimatedOpacityWidget({
    super.key,
    required this.isVisible,
    required this.animatedOpacityWidgetVariable,
  });

  final bool isVisible;
  final Widget animatedOpacityWidgetVariable;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        opacity: isVisible ? 1.0 : 0.0,
        duration: const Duration(milliseconds: 700),
        child: animatedOpacityWidgetVariable);
  }
}
