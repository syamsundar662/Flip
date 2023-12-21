import 'package:flip/application/presentation/screens/notification_screen/Widgets/notification_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          centerTitle: false,
        ),
        body: RefreshIndicator.adaptive(
            displacement: 0,
            onRefresh: () async {
              HapticFeedback.heavyImpact();
              await Future.delayed(const Duration(seconds: 3));
            },
            child: const NotificationTileWidget()));
  }
}
