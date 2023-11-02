import 'package:flutter/material.dart';

class VideoTimelineView extends StatefulWidget {
  const VideoTimelineView({super.key});

  @override
  State<VideoTimelineView> createState() => _VideoTimelineViewState();
}

class _VideoTimelineViewState extends State<VideoTimelineView> {
  int _itemCount = 4;
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
  ];

  void _onPageChanged(int page) {
    if (page == _itemCount - 1) {
      _itemCount += 4;
      colors.addAll([
        Colors.red,
        Colors.blue,
        Colors.green,
        Colors.yellow,
      ]);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: _itemCount,
      itemBuilder: (context, index) => Container(
        color: colors[index],
      ),
      onPageChanged: _onPageChanged,
    );
  }
}
