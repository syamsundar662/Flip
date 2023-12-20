import 'package:flip/application/presentation/screens/help/help.dart';
import 'package:flip/application/presentation/screens/login_screen/login_screen.dart';
import 'package:flip/application/presentation/screens/privacy_policy/privacy_policy.dart';
import 'package:flip/application/presentation/screens/profile_screen/widgets/show_sliding.dart';
import 'package:flip/data/firebase_services/auth_data_resourse/auth_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [ PrivacyPolicy(), const HelpAndSupport()];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView.builder(
        itemCount: SlideUpWidget.optionsForProfileScreen.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (index == 2) {
                showDeleteDialog(context);
              } else {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => pages[index]));
              }
            },
            child: ListTile(
                leading: SlideUpWidget.optionIconListForProfileScreen[index],
                title: Text(SlideUpWidget.optionsForProfileScreen[index])),
          );
        },
      ),
    );
  }

  void showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Signout?'),
          content: const Text('Are you sure you want to Signout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('CANCEL'),
            ),
            TextButton(
              onPressed: () {
                AuthServices().signOut();
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => const LoginScreen()));
              },
              child: const Text('SIGNOUT'),
            ),
          ],
        );
      },
    );
  }
}

              //     buttonTitle: SlideUpWidget.optionsForProfileScreen,
              //     buttonIcons: SlideUpWidget.optionIconListForProfileScreen);