import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/featurs/videos/repositories/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlayBackConfigModel> {
  final VideoPlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlayBackConfigModel(
      muted: value,
      autoplay: state.autoplay,
    );
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    state = PlayBackConfigModel(
      muted: state.muted,
      autoplay: value,
    );
  }

  @override
  PlayBackConfigModel build() {
    return PlayBackConfigModel(
      muted: _repository.isMuted(),
      autoplay: _repository.isAutoplay(),
    );
  }
}

final playbackConfigProvider =
    NotifierProvider<PlaybackConfigViewModel, PlayBackConfigModel>(
  () => throw UnimplementedError(),
);
