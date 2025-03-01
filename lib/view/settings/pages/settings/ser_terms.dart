import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/theme/color.dart';

class TermsOfServicePage extends StatelessWidget {
  const TermsOfServicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
          title: Text(
            "Terms of Service",
            style: GoogleFonts.poppins(),
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Terms of Service & Conditions",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              _buildSection("1. Acceptance of Terms",
                  "By using Nutrito, you agree to these Terms of Service and our Privacy Policy."),
              _buildSection("2. Use of the App",
                  "Nutrito helps analyze food ingredients, rate health impact, and recommend products."),
              _buildSection("3. Features & Their Terms", ""),
              _buildFeature("Food Ingredient Analysis",
                  "Nutrito scans ingredients but does not replace medical advice."),
              _buildFeature("Vegetable Quality Classification",
                  "The AI prediction may not be 100% accurate."),
              _buildFeature("Cooking AI Assistant",
                  "AI-generated recipes are for guidance and may not be nutritionally perfect."),
              _buildFeature("MealBook (Canteen Pre-Orders)",
                  "Orders cannot be canceled once confirmed."),
              _buildFeature(
                  "Fitness Tracking", "Nutrito is not a medical fitness tool."),
              _buildFeature(
                  "Subscription Model", "Payments are non-refundable."),
              _buildFeature("Google Sign-In & Authentication",
                  "We do not share authentication data."),
              _buildFeature(
                  "Secure Data Storage", "Credentials are securely stored."),
              _buildFeature(
                  "User Feedback", "Feedback may be used for AI improvement."),
              _buildFeature("Generative Model for Food Recommendations",
                  "AI suggests alternatives but is not responsible for inaccuracies."),
              _buildSection("4. Data Collection & Privacy",
                  "Nutrito does not sell personal data."),
              _buildSection("5. Limitation of Liability",
                  "Users should consult professionals for health decisions."),
              _buildSection(
                  "6. Changes to Terms", "Terms may be updated at any time."),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          SizedBox(height: 5),
          Text(content, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildFeature(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("- $title",
              style: GoogleFonts.poppins(
                  fontSize: 16, fontWeight: FontWeight.w500)),
          SizedBox(height: 3),
          Text(content, style: GoogleFonts.poppins(fontSize: 14)),
        ],
      ),
    );
  }
}
