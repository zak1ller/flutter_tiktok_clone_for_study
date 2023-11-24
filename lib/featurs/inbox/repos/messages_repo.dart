import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/inbox/models/message_model.dart';

class MessagesRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> sendMessage(MessageModel message) async {
    await _db
        .collection("chat_rooms")
        .doc("bhdLAar6dQZ11uCc6AXO")
        .collection("texts")
        .add(message.toJson());
  }
}

final messagesRepo = Provider(
  (ref) => MessagesRepository(),
);
