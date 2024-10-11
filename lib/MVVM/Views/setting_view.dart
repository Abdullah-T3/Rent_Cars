import 'package:bookingcars/generated/l10n.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback toggleLanguage;

  const SettingsPage({super.key, required this.toggleLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(S.of(context).Settings),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              S.of(context).Settings_Page,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleLanguage,
              child: Text(S.of(context).Switch_to_Arabic),
            ),
          ],
        ),
      ),
    );
  }
}
