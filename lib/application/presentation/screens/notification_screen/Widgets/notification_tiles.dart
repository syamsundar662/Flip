
import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/data/firebase_services/notification_data_resourse/notification_service.dart';
import 'package:flip/data/models/notification_model/notification.dart';
import 'package:flutter/material.dart';

class NotificationTileWidget extends StatelessWidget {
  const NotificationTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<NotificationWithUserProfile>>(
      stream: NotificationDataSource().getUserNotifications(),
      builder:
          (context, AsyncSnapshot<List<NotificationWithUserProfile>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No Notifications'),
          );
        } else {
          final notifications = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            shrinkWrap: true,
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.all(2),
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primary.withOpacity(.3),
                ),
                child: Row(
                  children: [
                    kWidth10,
                    CircleAvatar(
                      backgroundColor: Colors.grey[900],
                      backgroundImage: NetworkImage(
                          notifications[index].userProfile.profileImageUrl!),
                      radius: 30,
                    ),
                    kWidth10,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(notifications[index].notification.content),
                        ],
                      ),
                    ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.grey[900],
                    //   // backgroundImage:NetworkImage(notifications[index].notification.),
                    //   radius: 30,
                    // ),
                    kWidth10,
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
