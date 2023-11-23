import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/videos/models/video_model.dart';
import 'package:tiktok_clone/featurs/videos/view_models/playback_config_vm.dart';
import 'package:tiktok_clone/featurs/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/featurs/videos/views/widgets/video_comments.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinisehd;
  final int index;
  final VideoModel videoData;

  const VideoPost({
    super.key,
    required this.onVideoFinisehd,
    required this.index,
    required this.videoData,
  });

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  late final AnimationController _animationController;

  bool _isPlaying = false;
  bool _isPauseButtonTapped = false;
  // Disposed 이후 VisibilityDetector 호출을 막기 위해 dispoased를 체크하는 변수입니다.
  bool _isDisposed = false;

  late bool _isMutedOnlyThisVideo = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _initAnimationController();
  }

  @override
  void dispose() {
    _isDisposed = true;
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
    if (kIsWeb) {
      await _videoPlayerController.setVolume(0);
    }

    setState(() {});
  }

  void _initAnimationController() {
    _animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: const Duration(
        milliseconds: 100,
      ),
    );
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;

    _isMutedOnlyThisVideo = !_isMutedOnlyThisVideo;
    setState(() {});

    if (_isMutedOnlyThisVideo) {
      _videoPlayerController.setVolume(0);
    } else {
      _videoPlayerController.setVolume(1);
    }
  }

  void _onVideoChange() {
    _updateIsPlaying();
    // 동영상 재생이 완료되면 Finished 함수를 호출합니다.
    if (_videoPlayerController.value.isInitialized) {
      if (_videoPlayerController.value.duration ==
          _videoPlayerController.value.position) {
        widget.onVideoFinisehd.call();
      }
    }
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 &&
        !_videoPlayerController.value.isPlaying &&
        !_isPauseButtonTapped) {
      final autoplay = ref.read(playbackConfigProvider).autoplay;
      if (autoplay) {
        _videoPlayerController.play();
      }
    }
    if (!_isDisposed &&
        _videoPlayerController.value.isPlaying &&
        info.visibleFraction == 0) {
      _onTogglePause();
    }
  }

  /*
  사용자가 버튼을 눌러 일시정지 하는 경우에만 호출됩니다.
  */
  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _isPauseButtonTapped = true;
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _isPauseButtonTapped = false;
      _animationController.forward();
    }
  }

  void _updateIsPlaying() {
    setState(() {
      _isPlaying = _videoPlayerController.value.isPlaying;
    });
  }

  void _onCommnetTap(BuildContext context) async {
    if (_isPlaying) {
      // 사용자가 버튼을 눌러 일시정지 한 것이 아니기 때문에 onTogglePause를 호출하지 않습니다.
      _videoPlayerController.pause();
    }
    // bottom sheet가 dismiss 될때까지 기다립니다.
    await showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => const VideoComments(),
    );
    if (!_isPauseButtonTapped) {
      // 사용자가 버튼을 눌러 일시정지 한 상태인 경우에는 다시 재생하지 않습니다.
      // 사용자가 버튼을 누르지 않고 자동으로 pause된 상태에서는 onTogglePause를 호출하여 다시 재생합니다.
      _onTogglePause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key("${widget.index}"),
      onVisibilityChanged: _onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: _videoPlayerController.value.isInitialized
                ? VideoPlayer(_videoPlayerController)
                : Image.network(
                    widget.videoData.thumbnailUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: _onTogglePause,
              child: Container(
                color: Colors.red.withOpacity(0),
              ),
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animationController.value,
                    child: child,
                  );
                },
                child: AnimatedOpacity(
                  opacity: _isPlaying ? 0 : 1,
                  duration: const Duration(
                    milliseconds: 100,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: FaIcon(
                        FontAwesomeIcons.play,
                        color: Colors.white,
                        size: Sizes.size48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 20,
              top: 40,
              child: IconButton(
                onPressed: () => _onPlaybackConfigChanged(),
                icon: FaIcon(
                  _isMutedOnlyThisVideo
                      ? FontAwesomeIcons.volumeOff
                      : FontAwesomeIcons.volumeHigh,
                  color: Colors.white,
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(),
                ),
                Text(
                  "@${widget.videoData.creator}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: Sizes.size20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gaps.v2,
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        widget.videoData.description,
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundImage: NetworkImage(
                      "https://firebasestorage.googleapis.com/v0/b/tik-tok-clone-by-minsu.appspot.com/o/avatars%2F${widget.videoData.creatorUid}?alt=media&token=83f391cc-ecfb-414a-a247-4a0ab4012f09"),
                  child: Text(widget.videoData.creator),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidHeart,
                  text: "${widget.videoData.likes}",
                ),
                Gaps.v24,
                VideoButton(
                  onTap: () => _onCommnetTap(context),
                  icon: FontAwesomeIcons.solidComment,
                  text: "${widget.videoData.comments}",
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
