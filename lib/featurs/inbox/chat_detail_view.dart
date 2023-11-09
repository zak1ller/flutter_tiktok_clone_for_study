import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class ChatDetailView extends StatefulWidget {
  const ChatDetailView({super.key});

  @override
  State<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends State<ChatDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const ListTile(
          horizontalTitleGap: Sizes.size8,
          contentPadding: EdgeInsets.zero,
          title: Text(
            "Jason",
            style: TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Text("Active now"),
          leading: CircleAvatar(
            radius: Sizes.size24,
            foregroundImage: NetworkImage("https://source.unsplash.com/random"),
            child: Text("Jason"),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              FaIcon(
                FontAwesomeIcons.flag,
                color: Colors.black,
                size: Sizes.size20,
              ),
              Gaps.h16,
              FaIcon(
                FontAwesomeIcons.ellipsis,
                color: Colors.black,
                size: Sizes.size20,
              ),
            ],
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView.separated(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size16,
              vertical: Sizes.size16,
            ),
            itemBuilder: (context, index) {
              final isMine = index & 2 == 0;
              return Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment:
                    isMine ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isMine)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(Sizes.size16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Sizes.size16),
                        color: isMine
                            ? Colors.blue
                            : Theme.of(context).primaryColor,
                      ),
                      child: const Text(
                        "This is a message. adhsjkdhskjadh dsahjkdhsakj hhk asdhjkasdhjk ashdjkasdhjk ashdjksahdjk ashdjkhdkj",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  if (isMine)
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                ],
              );
            },
            separatorBuilder: (context, index) => Gaps.v8,
            itemCount: 10,
          ),
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: BottomAppBar(
              color: Colors.grey.shade100,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.size16,
                  vertical: Sizes.size8,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: Sizes.size48,
                        child: TextField(
                          minLines: null,
                          maxLines: null,
                          expands: true,
                          textInputAction: TextInputAction.newline,
                          decoration: InputDecoration(
                            hintText: "Write a message",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(Sizes.size24),
                              borderSide: BorderSide.none,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: Sizes.size16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Gaps.h20,
                    const FaIcon(FontAwesomeIcons.paperPlane),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
