import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Privacy Policy'),
              _buildText('Effective Date: [Insert Date]'),
              _buildSectionTitle('1. Introduction'),
              _buildText(
                  'Welcome to Nutrito! Your privacy is important to us. This Privacy Policy explains how we collect, use, and protect your information when you use our app.'),
              _buildSectionTitle('2. Information We Collect'),
              _buildBulletList([
                'Personal Information: Name, email address, contact details (when provided by you).',
                'Health and Nutritional Data: User-provided dietary preferences, food choices, and fitness preferences.',
                'Device Information: IP address, device type, operating system, and app usage data.',
                'Payment Information: Processed securely by Razorpay and not stored by us.',
              ]),
              _buildSectionTitle('3. How We Use Your Information'),
              _buildBulletList([
                'Provide personalized food analysis and recommendations.',
                'Improve our app functionality and user experience.',
                'Securely process payments and transactions.',
                'Communicate updates, promotional offers, and important notifications.',
              ]),
              _buildSectionTitle('4. Data Sharing and Security'),
              _buildBulletList([
                'We do not sell or rent your personal data.',
                'Your data may be shared with trusted third-party services (e.g., Razorpay for payments, Firebase for authentication) only for essential functionalities.',
                'We implement strict security measures to protect your data against unauthorized access.',
              ]),
              _buildSectionTitle('5. Your Choices and Rights'),
              _buildBulletList([
                'Review and update your personal information in the app settings.',
                'Request deletion of your account and associated data by contacting us.',
                'Opt out of promotional communications at any time.',
              ]),
              _buildSectionTitle('6. Third-Party Links'),
              _buildText(
                  'Nutrito may contain links to third-party websites or services. We are not responsible for their privacy practices, so we encourage you to review their policies.'),
              _buildSectionTitle('7. Changes to This Privacy Policy'),
              _buildText(
                  'We may update this Privacy Policy periodically. We will notify you of significant changes via app notifications or email.'),
              _buildSectionTitle('8. Contact Us'),
              _buildText('If you have any questions, contact us at:'),
              _buildText('📧 Email: omjamnekar877@gmail.com'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildText(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }

  Widget _buildBulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items
          .map((item) => Padding(
                padding: EdgeInsets.only(bottom: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("• ",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
