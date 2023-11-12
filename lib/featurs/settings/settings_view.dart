import 'package:flutter/material.dart';

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
          const AboutListTile(),
        ],
      ),
    );
  }
}
