import 'package:flip/application/presentation/utils/constants/constants.dart';
import 'package:flip/application/presentation/utils/image/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddStoryScreen extends StatelessWidget {
  const AddStoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add Story'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: screenFullHeight / 8,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: screenFullHeight / 8,
                    width: screenFullWidth / 2.2,
                    color: Colors.grey.shade900,
                    child: IconButton(onPressed: () {
                    }, icon: const Icon(Icons.file_copy)),
                  ),
                  Container(
                    height: screenFullHeight / 8,
                    width: screenFullWidth / 2.2,
                    color: Colors.grey.shade900,
                    child: IconButton(onPressed: () {}, icon: const Icon(Icons.camera)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
