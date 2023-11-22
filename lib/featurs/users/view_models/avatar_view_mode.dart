import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/featurs/users/repos/user_repository.dart';
import 'package:tiktok_clone/featurs/users/view_models/users_view_model.dart';

class AvatarViewModel extends AsyncNotifier<void> {
  late final UserRepository _repository;

  @override
  FutureOr<void> build() async {
    _repository = ref.read(userRepo);
  }

  Future<void> uploadAvatar(File file) async {
    state = const AsyncValue.loading();
    final fileName = ref.read(authRepo).user!.uid;
    state = await AsyncValue.guard(
      () async {
        await _repository.uploadAvatar(file, fileName);
        ref.read(usersProvider.notifier).onAvatarUpload();
      },
    );
  }
}

final avatarProvider = AsyncNotifierProvider<AvatarViewModel, void>(
  () => AvatarViewModel(),
);
