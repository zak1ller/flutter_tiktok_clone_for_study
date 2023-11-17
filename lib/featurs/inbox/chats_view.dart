import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/featurs/inbox/chat_detail_view.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({super.key});

  static const routeName = "chats";
  static const routeURL = "/chats";

  @override
  State<ChatsView> createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();

  final List<int> _items = [];

  void _addItem() {
    if (_key.currentState != null) {
      _key.currentState!.insertItem(
        _items.length,
        duration: const Duration(
          milliseconds: 200,
        ),
      );
      _items.add(_items.length);
    }
  }

  void _deleteItem(int index) {
    if (_key.currentState != null) {
      _key.currentState!.removeItem(
        index,
        (context, animation) => SizeTransition(
          sizeFactor: animation,
          child: _makeTile(index),
        ),
        duration: const Duration(
          milliseconds: 200,
        ),
      );
      _items.remove(_items[index]);
    }
  }

  void _onChatTap(int i) {
    context.pushNamed(
      ChatDetailView.routeName,
      pathParameters: {
        "chatId": "$i",
      },
    );
  }

  Widget _makeTile(int index) {
    return ListTile(
      onTap: () => _onChatTap(index),
      onLongPress: () => _deleteItem(index),
      leading: const CircleAvatar(
        radius: 30,
        foregroundImage: NetworkImage("https://source.unsplash.com/random"),
        child: Text("Jason"),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Minsu ($index)",
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            "2:16 PM",
            style: TextStyle(
              color: Colors.grey.shade500,
              fontSize: Sizes.size12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      subtitle: const Text(
        "Hello my name is minsu.",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text("Direct messages"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const FaIcon(
              FontAwesomeIcons.plus,
            ),
          ),
        ],
      ),
      body: AnimatedList(
        key: _key,
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size10,
        ),
        itemBuilder:
            (BuildContext context, int index, Animation<double> animation) {
          return FadeTransition(
            key: UniqueKey(),
            opacity: animation,
            child: SizeTransition(
              sizeFactor: animation,
              child: _makeTile(index),
            ),
          );
        },
      ),
    );
  }
}
