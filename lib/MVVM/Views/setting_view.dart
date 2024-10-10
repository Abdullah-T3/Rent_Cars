import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  final VoidCallback toggleLanguage;

  const SettingsPage({super.key, required this.toggleLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Localizations.localeOf(context).languageCode == 'en'
                  ? 'Settings Page'
                  : 'صفحة الإعدادات',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: toggleLanguage,
              child: Text(
                Localizations.localeOf(context).languageCode == 'en'
                    ? 'Switch to Arabic'
                    : 'التبديل إلى الإنجليزية',
              ),
            ),
          ],
        ),
      ),
    );
  }
}