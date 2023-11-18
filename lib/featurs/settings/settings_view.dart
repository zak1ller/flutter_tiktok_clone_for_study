import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/widgets/video_configuration/video_config.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  bool _notifications = false;

  void _onNoficationsChange(bool? newValue) {
    if (newValue == null) return;
    setState(() {
      _notifications = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          AnimatedBuilder(
            animation: videoConfig,
            builder: (context, child) => SwitchListTile(
              value: videoConfig.autoMute,
              onChanged: (value) {
                videoConfig.toggleAutoMute();
              },
              title: const Text("Auto Mute"),
              subtitle: const Text("Videos will be muted by default."),
            ),
          ),
          Switch(value: _notifications, onChanged: _onNoficationsChange),
          Checkbox(value: _notifications, onChanged: _onNoficationsChange),
          CheckboxListTile(
            value: _notifications,
            onChanged: _onNoficationsChange,
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
                      onPressed: () => Navigator.of(context).pop(),
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
