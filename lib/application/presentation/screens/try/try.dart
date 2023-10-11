import 'dart:math';

import 'package:flip/application/presentation/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

// don't forget "with SingleTickerProviderStateMixin"
class _HomePagesState extends State<HomePages> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _status = AnimationStatus.dismissed;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween(end: 1.0, begin: 0.0).animate(_controller)
      ..addListener(() {
        setState(() {

        });
      })
      ..addStatusListener((status) {
        _status = status;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Transform(
              alignment: FractionalOffset.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0015)
                ..rotateY(pi * _animation.value),
              child: Card(
                child: _animation.value <= 0.1 
                    ? Container(
                    height: 400,
                    width: 200,
                    decoration: BoxDecoration(
                    gradient: mainGradient,
                    borderRadius: BorderRadius.circular(30)
                   ),)
                    : Container(
                    height: 400,
                    width: 200,
                   decoration: BoxDecoration(
                    gradient: mainGradient,
                    borderRadius: BorderRadius.circular(30)
                   ),
                    ),
              ),
            ),
            // Vertical Flipping
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_status == AnimationStatus.dismissed) {
                    _controller.forward();
                  } else {
                    _controller.reverse();
                  }
                },
                child: const Text('tap'))
          ],
        ),
      ),
    );
  }
}