import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/inbox/view_models/messages_view_model.dart';

class ChatDetailView extends ConsumerStatefulWidget {
  const ChatDetailView({
    super.key,
    required this.chatId,
  });

  static const routeName = "chatDetail";
  static const routeURL = ":chatId";

  final String chatId;

  @override
  ConsumerState<ChatDetailView> createState() => _ChatDetailViewState();
}

class _ChatDetailViewState extends ConsumerState<ChatDetailView> {
  final TextEditingController _editingController = TextEditingController();

  void _onSendMessage() {
    final text = _editingController.text;
    if (text == "") return;
    ref.read(messagesProvider.notifier).sendMessage(text);
    _editingController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;

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
                          controller: _editingController,
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
                    GestureDetector(
                      onTap: isLoading ? null : _onSendMessage,
                      child: FaIcon(isLoading
                          ? FontAwesomeIcons.hourglass
                          : FontAwesomeIcons.paperPlane),
                    ),
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
