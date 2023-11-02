import 'package:flutter/material.dart';
import 'package:tiktok_clone/featurs/videos/widgets/video_post.dart';

class VideoTimelineView extends StatefulWidget {
  const VideoTimelineView({super.key});

  @override
  State<VideoTimelineView> createState() => _VideoTimelineViewState();
}

class _VideoTimelineViewState extends State<VideoTimelineView> {
  final PageController _pageController = PageController();
  int _itemCount = 4;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 150),
      curve: Curves.linear,
    );
    if (page == _itemCount - 1) {
      _itemCount += 4;
    }
    setState(() {});
  }

  void _onVideoFinished() {
    // _pageController.nextPage(
    //   duration: const Duration(
    //     milliseconds: 150,
    //   ),
    //   curve: Curves.linear,
    // );
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) => VideoPost(
        onVideoFinisehd: _onVideoFinished,
        index: index,
      ),
      onPageChanged: _onPageChanged,
    );
  }
}
