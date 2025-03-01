import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:shared_preferences/shared_preferences.dart';

final languageProvider = StateNotifierProvider<LanguageController, String>(
  (ref) => LanguageController(),
);

class LanguageController extends StateNotifier<String> {
  LanguageController() : super('English') {
    _loadLanguage();
  }

  Future<void> _loadLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getString('selected_language') ?? 'English';
  }

  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', language);
    state = language;
  }
}

class SupportLanguagePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedLanguage = ref.watch(languageProvider);
    final notifier = ref.read(languageProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Language Settings'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Text(
                    'Select Your Preferred Language',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(height: 10),
                Flexible(
                  flex: 1,
                  child: DropdownButton<String>(
                    value: selectedLanguage,
                    onChanged: (newValue) {
                      if (newValue != null) {
                        notifier.setLanguage(newValue);
                      }
                    },
                    items: [
                      'English',
                      'Hindi',
                      'Spanish',
                      'French',
                      'German',
                      'Chinese',
                      'Japanese'
                    ]
                        .map((lang) => DropdownMenuItem(
                              value: lang,
                              child: Text(lang),
                            ))
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        width: double.infinity,
        height: 90,
        color: Colors.black,
        child: TextButton(
          onPressed: () => _showLanguageDownloadOptions(context),
          child: Text(
            'Manage Language Packs',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _showLanguageDownloadOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Language Pack Options',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () => _downloadLanguage(context),
                  child: Text('Download New Language Pack',
                      style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () => _tuneLanguageSettings(context),
                  child: Text('Tune Language Usage',
                      style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () => _deprecateLanguagePacks(context),
                  child: Text('Deprecate Old Language Packs',
                      style: GoogleFonts.poppins(color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _downloadLanguage(BuildContext context) async {
    Navigator.pop(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Downloading...'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(),
            SizedBox(height: 10),
            Text('Downloading selected language pack...'),
          ],
        ),
      ),
    );

    await Future.delayed(Duration(seconds: 5));

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Language pack downloaded successfully!')),
    );
  }

  void _tuneLanguageSettings(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Language tuning options coming soon!')),
    );
  }

  void _deprecateLanguagePacks(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Deprecating old language packs...')),
    );
  }
}
