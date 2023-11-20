import 'package:flutter/foundation.dart';
import 'package:tiktok_clone/featurs/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/featurs/videos/repositories/video_playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final VideoPlaybackConfigRepository _repository;

  late final PlayBackConfigModel _model = PlayBackConfigModel(
    muted: _repository.isMuted(),
    autoplay: _repository.isAutoplay(),
  );

  PlaybackConfigViewModel(this._repository);

  bool get muted => _model.muted;
  bool get autoplay => _model.autoplay;
  
  void setMuted(bool value) {
    _repository.setMuted(value);
    _model.muted = value;
    notifyListeners();
  }

  void setAutoplay(bool value) {
    _repository.setAutoplay(value);
    _model.autoplay = value;
    notifyListeners();
  }
}
