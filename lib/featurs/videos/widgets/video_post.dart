import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils/position_manager.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinisehd;
  final int index;

  const VideoPost({
    super.key,
    required this.onVideoFinisehd,
    required this.index,
  });

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost>
    with SingleTickerProviderStateMixin {
  final VideoPlayerController _videoPlayerController =
      VideoPlayerController.asset("assets/videos/video.mp4");
  late final AnimationController _animationController;

  final GlobalKey _seeMoreTextKey = GlobalKey();

  bool _isPlaying = false;
  bool _isTappedSeeMore = false;

  @override
  void initState() {
    super.initState();
    _initVideoPlayer();
    _initAnimationController();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  void _initVideoPlayer() async {
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    _videoPlayerController.addListener(_onVideoChange);
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
    if (info.visibleFraction == 1 && !_videoPlayerController.value.isPlaying) {
      _videoPlayerController.play();
    }
  }

  void _onTogglePause() {
    if (_videoPlayerController.value.isPlaying) {
      _videoPlayerController.pause();
      _animationController.reverse();
    } else {
      _videoPlayerController.play();
      _animationController.forward();
    }
  }

  void _updateIsPlaying() {
    setState(() {
      _isPlaying = _videoPlayerController.value.isPlaying;
    });
  }

  void _onSeeMoreTap() {
    setState(() {
      _isTappedSeeMore = !_isTappedSeeMore;
    });
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
                : Container(
                    color: Colors.black,
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
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(),
                ),
                const Text(
                  "@Json",
                  style: TextStyle(
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
                        "sdjlkadkladn slakdjslkadjklad dsjakldjskladn alkdjakldjslkadjsla dlkajdskladjslkadjlkadjkldjk",
                        overflow: TextOverflow.ellipsis,
                        maxLines: _isTappedSeeMore ? 10 : 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: Sizes.size16,
                        ),
                      ),
                    ),
                    Container(),
                    _isTappedSeeMore
                        ? Container()
                        : GestureDetector(
                            onTap: _onSeeMoreTap,
                            child: Text(
                              "See more",
                              key: _seeMoreTextKey,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                    _isTappedSeeMore
                        ? Container()
                        : Expanded(
                            child: Container(),
                          ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: WidgetManager.getPositionFromKey(_seeMoreTextKey) == null
                ? 0
                : WidgetManager.getPositionFromKey(_seeMoreTextKey)!.dx - 5,
            top: WidgetManager.getPositionFromKey(_seeMoreTextKey) == null
                ? 0
                : WidgetManager.getPositionFromKey(_seeMoreTextKey)!.dy - 5,
            child: WidgetManager.getSize(_seeMoreTextKey) == null
                ? Container()
                : Container(
                    color: Colors.black.withOpacity(0.5),
                    width: WidgetManager.getSize(_seeMoreTextKey)!.width + 10,
                    height: WidgetManager.getSize(_seeMoreTextKey)!.height + 10,
                  ),
          ),
        ],
      ),
    );
  }
}
