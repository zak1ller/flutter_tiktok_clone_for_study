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
  bool _isWriting = false;

  final ScrollController _scrollController = ScrollController();

  void _onCloseTap() {
    Navigator.of(context).pop();
  }

  void _startWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _stopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onSendTap() {
    _stopWriting();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.7,
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
        body: GestureDetector(
          onTap: _stopWriting,
          child: Stack(
            children: [
              Scrollbar(
                controller: _scrollController,
                child: ListView.separated(
                  controller: _scrollController,
                  separatorBuilder: (context, index) => Gaps.v16,
                  padding: const EdgeInsets.only(
                    left: Sizes.size16,
                    right: Sizes.size16,
                    bottom: Sizes.size96 + Sizes.size20,
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
              ),
              Positioned(
                width: size.width,
                bottom: 0,
                child: BottomAppBar(
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size8,
                      bottom: Sizes.size16,
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: Sizes.size16,
                          backgroundColor: Colors.grey.shade500,
                          foregroundColor: Colors.white,
                          child: const Text("Jason"),
                        ),
                        Gaps.h8,
                        Expanded(
                          child: SizedBox(
                            height: Sizes.size40,
                            child: TextField(
                              onTap: _startWriting,
                              minLines: null,
                              maxLines: null,
                              expands: true,
                              textInputAction: TextInputAction.newline,
                              cursorColor: Theme.of(context).primaryColor,
                              decoration: InputDecoration(
                                hintText: "Write a comment",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(
                                    Sizes.size12,
                                  ),
                                  borderSide: BorderSide.none,
                                ),
                                filled: true,
                                fillColor: Colors.grey.shade200,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: Sizes.size12,
                                ),
                                suffixIcon: Padding(
                                  padding:
                                      const EdgeInsets.only(right: Sizes.size8),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const FaIcon(
                                        FontAwesomeIcons.at,
                                        color: Colors.black,
                                      ),
                                      Gaps.h12,
                                      const FaIcon(
                                        FontAwesomeIcons.gift,
                                        color: Colors.black,
                                      ),
                                      Gaps.h12,
                                      const FaIcon(
                                        FontAwesomeIcons.faceSmile,
                                        color: Colors.black,
                                      ),
                                      if (_isWriting) Gaps.h12,
                                      if (_isWriting)
                                        GestureDetector(
                                          onTap: _onSendTap,
                                          child: FaIcon(
                                            FontAwesomeIcons.circleArrowUp,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
