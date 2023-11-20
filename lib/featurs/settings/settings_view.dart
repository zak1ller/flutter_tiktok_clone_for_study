import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/featurs/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/featurs/videos/view_models/playback_config_vm.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            value: ref.watch(playbackConfigProvider).muted,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setMuted(value);
            },
            title: const Text("Auto Mute"),
            subtitle: const Text("Videos will be muted by default."),
          ),
          SwitchListTile(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) {
              ref.read(playbackConfigProvider.notifier).setAutoplay(value);
            },
            title: const Text("Auto Play"),
            subtitle: const Text("Videos will be muted by default."),
          ),
          CheckboxListTile(
            value: ref.watch(playbackConfigProvider).autoplay,
            onChanged: (value) {},
            title: const Text("Enable notifications"),
            activeColor: Colors.black,
          ),
          ListTile(
            onTap: () async {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1980),
                lastDate: DateTime.now(),
              );
              showTimePicker(
                context: context,
                initialTime: TimeOfDay.now(),
              );
              showDateRangePicker(
                context: context,
                firstDate: DateTime(1980),
                lastDate: DateTime.now(),
              );
            },
            title: const Text(
              "What is your birthday?",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          ListTile(
            title: const Text("Log out (iOS)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Log out"),
                  content: const Text("are you sure want to log out?"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        ref.read(authRepo).signOut();
                        context.go("/");
                      },
                      isDestructiveAction: true,
                      child: const Text("Log out"),
                    ),
                    CupertinoDialogAction(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (Android)"),
            textColor: Colors.red,
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Log out"),
                  content: const Text("are you sure want to log out?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Log out"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
          ),
          ListTile(
            title: const Text("Log out (iOS / Bottom)"),
            textColor: Colors.red,
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Log out"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {},
                      isDestructiveAction: true,
                      child: const Text("Log out"),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {},
                      child: const Text("Cancel"),
                    ),
                  ],
                ),
              );
            },
          ),
          const AboutListTile(),
        ],
      ),
    );
  }
}
