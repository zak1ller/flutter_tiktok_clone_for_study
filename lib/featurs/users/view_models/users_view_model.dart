import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/featurs/users/models/user_profile_model.dart';
import 'package:tiktok_clone/featurs/users/repos/user_repository.dart';

class UsersViewModel extends AsyncNotifier<UserProfileModel> {
  late final UserRepository _repository;

  @override
  FutureOr<UserProfileModel> build() {
    _repository = ref.read(userRepo);
    return UserProfileModel.empty();
  }

  Future<void> createAccount(UserCredential credential) async {
    state = AsyncValue.loading();
    final profile = UserProfileModel(
      uid: credential.user!.uid,
      name: credential.user!.displayName ?? "Anon",
      email: credential.user!.email ?? "anon@anon.com",
      bio: "",
      link: "undefined",
    );
    await _repository.createProfile(profile);
    state = AsyncValue.data(profile);
  }
}

final usersProvider = AsyncNotifierProvider<UsersViewModel, UserProfileModel>(
  () => UsersViewModel(),
);
