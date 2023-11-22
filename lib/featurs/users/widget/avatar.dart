import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class Avatar extends ConsumerWidget {
  final String name;

  const Avatar({
    super.key,
    required this.name,
  });

  Future<void> _onAvatarTap() async {
    final xFile = await ImagePicker().pickImage(
      imageQuality: 40,
      source: ImageSource.gallery,
      maxWidth: 150,
      maxHeight: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: _onAvatarTap,
      child: CircleAvatar(
        radius: 50,
        foregroundImage: const NetworkImage(
          "https://source.unsplash.com/random",
        ),
        child: Text(name),
      ),
    );
  }
}
