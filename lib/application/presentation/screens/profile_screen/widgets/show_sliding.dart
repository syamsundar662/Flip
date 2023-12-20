import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';

class SlideUpWidget {
  Future<dynamic> showSlidingBoxWidget(
      {required BuildContext context,
      required double height,
      required List<String> buttonTitle,
      required List<IconButton> buttonIcons}) {
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
          body: _body(buttonTitle, buttonIcons, context),
        ));
  }

  _body(
    List<String> buttonTitle,
    List<IconButton> buttonIcons,
    BuildContext context,
  ) {
    return ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (ctx, index) {
          return const Divider(
            thickness: .001,
          );
        },
        itemCount: buttonIcons.length,
        itemBuilder: (itemBuilder, index) {
          return GestureDetector(
            onTap: () {},
            child: SizedBox(
              height: 50,
              width: double.infinity,
              child: ListTile(
                leading: buttonIcons[index],
                title: Text(buttonTitle[index]),
              ),
            ),
          );
        });
  }

  static List<IconButton> optionIconListForProfileScreen = [
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
    'Privacy and Security',
    'Help and Support',
    'Sign out',
  ];
}
