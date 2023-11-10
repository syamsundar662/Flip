import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sliding_box/flutter_sliding_box.dart';

class SlideUpWidget {
  

Future<dynamic> showSlidingBoxWidget(BuildContext context,) {
  return showSlidingBox(
      context: context,
      box: SlidingBox(
        maxHeight: screenFullHeight / 1.3,
        color: Theme.of(context).colorScheme.onTertiary,
        style: BoxStyle.shadow,
        draggableIconBackColor: Theme.of(context).colorScheme.onTertiary,
        body: _body(),
      ));
}

_body() {
  return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) {
        return const Divider(
          thickness: .001,
        );
      },
      itemCount: options.length,
      itemBuilder: (itemBuilder, index) {
        return SizedBox(
          height: 50,
          width: double.infinity,
          child: ListTile(
            leading: iconButtons[index],
            title: Text(options[index]),
          ),
        );
      });
}

List<String> options = [
  'Settings',
  'Saves',
  'Privacy and Security',
  'Help',
  'Sign out',
];
List<IconButton> iconButtons = [
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
}