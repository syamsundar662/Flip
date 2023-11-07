import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostMainCommonButtons extends StatelessWidget {
  const PostMainCommonButtons({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(
            Iconsax.like5,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.note),
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.share),
        ),
        const Spacer(),
        IconButton(
          onPressed: () {},
          icon: const Icon(Iconsax.save_2),
        ),
      ],
    );
  }
}
