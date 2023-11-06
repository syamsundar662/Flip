import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/material.dart';

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        shrinkWrap: true,
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(2),
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.primary.withOpacity(.3)),
            child: const Row(
              children: [
                kWidth10,
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                  radius: 30,
                ),
                kWidth10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Ntofitication'),
                    // Text('Message'),
                  ],
                ),
                Spacer(),
                CircleAvatar(
                  backgroundImage: AssetImage(
                      'assets/brunette-girl-walking-through-park-during-autumn.jpg'),
                  radius: 30,
                ),
                kWidth10
              ],
            ),
          );
        });
  }
}
