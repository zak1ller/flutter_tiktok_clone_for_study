import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoComments extends StatefulWidget {
  const VideoComments({super.key});

  @override
  State<VideoComments> createState() => _VideoCommentsState();
}

class _VideoCommentsState extends State<VideoComments> {
  void _onCloseTap() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(Sizes.size16),
        topRight: Radius.circular(Sizes.size16),
      )),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("22,796 Comments"),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: _onCloseTap,
              icon: const FaIcon(FontAwesomeIcons.xmark),
            ),
          ],
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) => Gaps.v16,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size16,
            // vertical: Sizes.size16,
          ),
          itemCount: 10,
          itemBuilder: (context, index) => Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: Sizes.size16,
                child: Text("Jason"),
              ),
              Gaps.h8,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Jason",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    Gaps.v5,
                    const Text(
                      "djaskldjmc dlksajdlksajd djlkasjdk lsaj dlkadj dskalj dkl sajdlksaj djsalkdjlks",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              Gaps.h8,
              Column(
                children: [
                  FaIcon(
                    FontAwesomeIcons.heart,
                    size: Sizes.size20,
                    color: Colors.grey.shade500,
                  ),
                  Gaps.v5,
                  Text(
                    "52.2K",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.white,
          child: Row(
            children: [
              CircleAvatar(
                radius: Sizes.size16,
                backgroundColor: Colors.grey.shade500,
                foregroundColor: Colors.white,
                child: const Text("Jason"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
