import 'dart:async';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/featurs/videos/repositories/%08videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(File video) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final task = await _repository.uploadVideoFile(
        video,
        user!.uid,
      );
      if (task.metadata != null) {
        await _repository.saveVido();
      }
    });
  }
}
