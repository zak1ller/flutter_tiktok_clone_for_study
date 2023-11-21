import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/users/models/user_profile_model.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  @override
  FutureOr<UserProfileModel> build() {
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    state = AsyncValue.data(
      UserProfileModel(
        uid: credential.user!.uid,
        name: credential.user!.displayName ?? "Anon",
        email: credential.user!.email ?? "anon@anon.com",
        bio: "",
        link: "undefined",
      ),
    );
    
  }
}

final usersProvider = AsyncNotifierProvider(
  () => UsersViewModel(),
);
