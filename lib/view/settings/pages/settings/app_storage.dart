import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';

class StorageManagementPage extends StatefulWidget {
  @override
  _StorageManagementPageState createState() => _StorageManagementPageState();
}

class _StorageManagementPageState extends State<StorageManagementPage> {
  int appData = 120;
  int cacheData = 50;
  int languagePacks = 30;
  bool _autoCleanupEnabled = false;

  void _clearCache() async {
    setState(() {
      cacheData = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Cache cleared!')),
    );
  }

  void _deleteUnusedData() async {
    setState(() {
      languagePacks = 0;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Unused data deleted!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Storage Management'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Storage Usage',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text('App Data'),
              subtitle: Text('Used: ${appData}MB'),
              trailing: Icon(Icons.storage),
            ),
            ListTile(
              title: Text('Cache'),
              subtitle: Text('Used: ${cacheData}MB'),
              trailing: Icon(Icons.cached),
            ),
            ListTile(
              title: Text('Language Packs'),
              subtitle: Text('Used: ${languagePacks}MB'),
              trailing: Icon(Icons.language),
            ),
            SizedBox(height: 20),
            Text(
              'Storage Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: _clearCache,
                child: Text(
                  'Clear Cache',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
            Gap(20),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(5),
              ),
              child: TextButton(
                onPressed: _deleteUnusedData,
                child: Text(
                  'Delete Unused Data',
                  style: GoogleFonts.poppins(color: Colors.white),
                ),
              ),
            ),
            SwitchListTile(
              title: Text('Enable Auto-Cleanup'),
              value: _autoCleanupEnabled,
              onChanged: (value) {
                setState(() {
                  _autoCleanupEnabled = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
