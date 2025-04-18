import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _apppGiturl = Uri.parse('https://github.com/omjamnekar/nutrito-app');

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About Nutrito',
          style: GoogleFonts.poppins(color: Colors.black45),
        ),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20),
              Text(
                'Smart Choices for a Healthier Life',
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(10),
              Text(
                'Nutrito is your ultimate food analysis app, built with Flutter for seamless performance. Designed to simplify food choices, Nutrito leverages AI-powered machine learning to scan, analyze, and provide instant feedback on food ingredients.',
                style:
                    GoogleFonts.poppins(fontSize: 16, color: Colors.blueGrey),
              ),
              Gap(20),
              Text(
                'Why Choose Nutrito?',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
              ),
              Gap(10),
              _buildFeatureTile(" Real-Time Ingredient Analysis",
                  "Scan and get instant health insights."),
              _buildFeatureTile(
                  " Smart Substitutions", "Find healthier alternatives."),
              _buildFeatureTile(" Personalized Nutrition",
                  "Tailored recommendations just for you."),
              _buildFeatureTile(" Transparent Food Information",
                  "Understand what’s in your food."),
              Gap(10),
              Text(
                'How Nutrito Works',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
              ),
              Gap(10),
              _buildFeatureTile("Scan Your Food",
                  "Use Nutrito’s scanner to capture ingredient details."),
              _buildFeatureTile("Instant Analysis",
                  "AI deciphers ingredients and highlights risks."),
              _buildFeatureTile("Get Health Ratings",
                  "See nutritional scores to make better decisions."),
              _buildFeatureTile("Smarter Alternatives",
                  "Discover healthier replacements effortlessly."),
              Gap(20),
              Divider(),
              Text(
                'About Developers',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
              ),
              Gap(10),
              ListTile(
                leading: Icon(Icons.person,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
                title: Text('Om Jamnekar & Shiva Aleti'),
                subtitle: Text('Developers of Nutrito'),
              ),
              ListTile(
                leading: Icon(Icons.email,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
                title: Text('omjamnekar877@gmail.com'),
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'omjjamnekar@gmail.com',
                    query:
                        'subject=Feedback on Nutrito App&body=Hello Nutrito Team!',
                  );

                  try {
                    if (!await launchUrl(emailLaunchUri)) {
                      throw Exception('Could not launch $emailLaunchUri');
                    }
                  } catch (e) {
                    print("Error Sending Email: $e");
                  }
                },
              ),
              ListTile(
                leading: Icon(Icons.email,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
                title: Text('aletishiva218@gmail.com'),
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'aletishiva218@gmail.com',
                    query:
                        'subject=Feedback on Nutrito App&body=Hello Nutrito Team!',
                  );

                  try {
                    if (!await launchUrl(emailLaunchUri)) {
                      throw Exception('Could not launch $emailLaunchUri');
                    }
                  } catch (e) {
                    print("Error Sending Email: $e");
                  }
                },
              ),
              Gap(20),
              Divider(),
              Text(
                'GitHub',
                style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
              ),
              SizedBox(height: 10),
              ListTile(
                leading: Icon(Icons.link,
                    color: ColorManager.bluePrimary.withOpacity(0.8)),
                title: Text('Nutrito Repository'),
                subtitle: Text('github.com/omjamnekar/nutrito-app'),
                onTap: () async {
                  try {
                    if (!await launchUrl(_apppGiturl)) {
                      throw Exception('Could not launch $_apppGiturl');
                    }
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  }
                },
              ),
              Gap(50),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "version 1.0.0",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureTile(String title, String subtitle) {
    return ListTile(
      leading: Icon(Icons.check_circle,
          color: ColorManager.bluePrimary.withOpacity(0.8)),
      title:
          Text(title, style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
    );
  }
}
