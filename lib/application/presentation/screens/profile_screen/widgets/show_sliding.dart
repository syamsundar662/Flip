import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';
import 'package:iconsax/iconsax.dart';

class SlideUpWidget {
  Future<dynamic> showSlidingBoxWidget(BuildContext context, double height,
      List<String> buttonTitle, List<IconButton> buttonIcons) {
    return showSlidingBox(
        barrierDismissible: true,
        context: context,
        box: SlidingBox(
          collapsed: true,
          draggable: true,
          maxHeight: height,
          color: Theme.of(context).colorScheme.onTertiary,
          style: BoxStyle.shadow,
          draggableIconBackColor: Theme.of(context).colorScheme.onTertiary,
          body: _body(buttonTitle, buttonIcons),
        ));
  }

  _body(List<String> buttonTitle, List<IconButton> buttonIcons) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: .001,
          );
        },
        itemCount: buttonIcons.length,
        itemBuilder: (itemBuilder, index) {
          return SizedBox(
            height: 50,
            width: double.infinity,
            child: ListTile(
              leading: buttonIcons[index],
              title: Text(buttonTitle[index]),
            ),
          );
        });
  }

static List<IconButton> optionIconListForProfileScreen = [
    IconButton(
      icon: const Icon(Icons.settings),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Icons.bookmark),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Icons.privacy_tip_rounded),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Icons.help),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Icons.logout),
      onPressed: () {},
    ),
  ];
  

//view post from userprofile


 static List<String> optionsForProfileScreen = [
    'Settings',
    'Saves',
    'Privacy and Security',
    'Help',
    'Sign out',
  ];
 static List<String> optionsForProfilePostViewScreen = [
    'Edit post',
    'Delete',
  ];
   static List<IconButton> optionIconListForProfilePostViewScreen = [
    IconButton(
      icon: const Icon(Iconsax.edit),
      onPressed: () {},
    ),
    IconButton(
      icon: const Icon(Iconsax.profile_delete), 
      onPressed: () {},
    ),
    
  ];
}
