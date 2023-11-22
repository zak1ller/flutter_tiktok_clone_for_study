import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/featurs/users/view_models/avatar_view_mode.dart';

class Avatar extends ConsumerWidget {
  final String name;
  final bool hasAvatar;
  final String uid;

  const Avatar({
    super.key,
    required this.name,
    required this.hasAvatar,
    required this.uid,
  });

  Future<void> _onAvatarTap(WidgetRef ref) async {
    final xFile = await ImagePicker().pickImage(
      imageQuality: 40,
      source: ImageSource.gallery,
      maxWidth: 150,
      maxHeight: 150,
    );
    if (xFile != null) {
      final file = File(xFile.path);
      ref.read(avatarProvider.notifier).uploadAvatar(file);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(avatarProvider).isLoading;
    return GestureDetector(
      onTap: isLoading ? null : () => _onAvatarTap(ref),
      child: CircleAvatar(
        radius: 50,
        foregroundImage: hasAvatar
            ? NetworkImage(
                "https://firebasestorage.googleapis.com/v0/b/tik-tok-clone-by-minsu.appspot.com/o/avatars%2F$uid?alt=media&token=83f391cc-ecfb-414a-a247-4a0ab4012f09",
              )
            : null,
        child: Text(name),
      ),
    );
  }
}
