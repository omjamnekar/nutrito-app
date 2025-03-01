import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdatePage extends StatelessWidget {
  final String latestVersion = "2.0.0"; // Replace with actual latest version
  final String currentVersion = "1.0.0"; // Replace with actual app version
  final String updateUrl =
      "https://play.google.com/store/apps/details?id=com.example.app"; // Replace with your app link

  @override
  Widget build(BuildContext context) {
    bool needsUpdate = latestVersion != currentVersion;

    return Scaffold(
      appBar: AppBar(title: Text("Update Available")),
      body: Center(
        child: needsUpdate
            ? Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.system_update,
                        size: 100,
                        color: ColorManager.bluePrimary.withOpacity(0.4)),
                    SizedBox(height: 20),
                    Text(
                      "A new version ($latestVersion) is available!",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Please update to continue using the app with the latest features.",
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton(
                        onPressed: () => _showUpdateDialog(context),
                        child: Text(
                          "Update Now",
                          style: GoogleFonts.poppins(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Text(
                "You're using the latest version!",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        //backgroundColor: ColorManager.bluePrimary.withOpacity(0.5),
        title: Text("Update Required"),
        content: Text(
            "To continue using this app, please update to the latest version."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Later"),
          ),
          ElevatedButton(
            onPressed: () => _launchURL(updateUrl),
            child: Text("Update Now"),
          ),
        ],
      ),
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
