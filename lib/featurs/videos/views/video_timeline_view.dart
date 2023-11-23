import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/videos/view_models/timeline_vm.dart';
import 'package:tiktok_clone/featurs/videos/views/widgets/video_post.dart';

class VideoTimelineView extends ConsumerStatefulWidget {
  const VideoTimelineView({super.key});

  @override
  VideoTimelineViewState createState() => VideoTimelineViewState();
}

class VideoTimelineViewState extends ConsumerState<VideoTimelineView> {
  final PageController _pageController = PageController();
  int _itemCount = 0;

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
      ref.watch(timelineProvider.notifier).fetchNextPage();
    }
  }

  void _onVideoFinished() {
    // _pageController.nextPage(
    //   duration: const Duration(
    //     milliseconds: 150,
    //   ),
    //   curve: Curves.linear,
    // );
  }

  Future<void> _onRefresh() {
    return ref.watch(timelineProvider.notifier).refresh();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos. $error",
              style: const TextStyle(color: Colors.white),
            ),
          ),
          data: (videos) {
            _itemCount = videos.length;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              edgeOffset: 20,
              color: Theme.of(context).primaryColor,
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.vertical,
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final videoData = videos[index];
                  return VideoPost(
                    onVideoFinisehd: _onVideoFinished,
                    index: index,
                    videoData: videoData,
                  );
                },
                onPageChanged: _onPageChanged,
              ),
            );
          },
        );
  }
}
