import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:nutrito/util/theme/color.dart';
import 'package:url_launcher/url_launcher.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  File? _image; // To store the selected screenshot

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  // Function to pick an image from gallery or take a new picture
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  void _submitFeedback(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final feedbackText = _feedbackController.text;

      // Here, you can send the feedbackText and _image (if available) to your backend or email
      print('Feedback text: $feedbackText');
      if (_image != null) {
        print('Screenshot attached: ${_image!.path}');
      }

      // Send email
      String email =
          'mailto:omjjamnekar@gmail.com?subject=App Feedback&body=$feedbackText';
      if (_image != null) {
        // Note: Attaching files in mailto links is not supported by all email clients.
        // You might need to use a backend service to handle attachments.
        email += '&attachment=${Uri.encodeComponent(_image!.path)}';
      }
      await launch(email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Feedback submitted successfully!')),
      );

      // Clear form after submission
      _feedbackController.clear();
      setState(() {
        _image = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.4),
        title: Text('Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'We value your feedback!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _feedbackController,
                decoration: InputDecoration(
                  labelText: 'Your Feedback',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your feedback';
                  }
                  return null;
                },
                maxLines: 5,
              ),
              SizedBox(height: 16),
              if (_image != null) ...[
                Center(
                  child: Image.file(
                    _image!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: 10),
              ],
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: TextButton.icon(
                  onPressed: _pickImage,
                  icon: Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Attach Screenshot',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                ),
                child: TextButton.icon(
                  onPressed: () => _submitFeedback(context),
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  label: Text(
                    'Submit Feedback',
                    style: GoogleFonts.poppins(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
