import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:kolky_vysledkovy_servis/assets/other_assets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  static const keyCommentsEnabled = 'key-commentsEnabled';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nastavenia")),
        body: Padding(
          padding: EdgeInsets.all(assetsPadding),
          child: SwitchSettingsTile(
            title: "Zobrazovať komentáre",
            settingKey: keyCommentsEnabled,
          ),
        ));
  }
}
