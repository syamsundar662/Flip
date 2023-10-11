import 'package:flutter/material.dart';
class FlipAlignAnimation extends StatefulWidget {
  const FlipAlignAnimation({super.key, required this.animationWidget});

final Widget animationWidget;
  @override
  State<FlipAlignAnimation> createState() => _FlipAlignAnimationState();
}

class _FlipAlignAnimationState extends State<FlipAlignAnimation> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        selected = !selected;
      }),
      child: AnimatedAlign(
        alignment: selected ? Alignment.topCenter : Alignment.bottomCenter,
        duration: const Duration(milliseconds: 3000),
        curve: Curves.fastOutSlowIn,
        child: widget.animationWidget
      ),
    );
  }
}
