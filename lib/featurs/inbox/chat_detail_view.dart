import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/authentication/repos/authentication_repo.dart';
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
          ref.watch(chatProvider).when(
                data: (data) {
                  return ListView.separated(
                    padding: EdgeInsets.only(
                      left: Sizes.size16,
                      right: Sizes.size16,
                      top: Sizes.size16,
                      bottom:
                          MediaQuery.of(context).padding.bottom + Sizes.size64,
                    ),
                    itemBuilder: (context, index) {
                      final message = data[index];
                      final isMine =
                          message.userId == ref.watch(authRepo).user!.uid;

                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: isMine
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!isMine)
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.1,
                            ),
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(Sizes.size16),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(Sizes.size16),
                                color: isMine
                                    ? Colors.blue
                                    : Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(
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
                    itemCount: data.length,
                  );
                },
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
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
