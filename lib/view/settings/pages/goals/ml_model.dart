import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nutrito/util/data/models.dart';
import 'package:nutrito/util/theme/color.dart';

class MLModelShowcase extends StatelessWidget {
  const MLModelShowcase({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ML Model Showcase')),
      body: ListView.builder(
        itemCount: models.length,
        itemBuilder: (context, index) {
          final model = models[index];
          return Card(
            shadowColor: Colors.black87,
            margin: const EdgeInsets.all(12),
            elevation: 2,
            child: ListTile(
              title: Text(model['name'],
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              subtitle: Text(model['description'],
                  maxLines: 2, overflow: TextOverflow.ellipsis),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () => Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      FadeTransition(
                    opacity: animation,
                    child: MLModelDetailPage(model: model),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MLModelDetailPage extends StatefulWidget {
  final Map<String, dynamic> model;

  const MLModelDetailPage({super.key, required this.model});

  @override
  State<MLModelDetailPage> createState() => _MLModelDetailPageState();
}

class _MLModelDetailPageState extends State<MLModelDetailPage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Trigger opacity change after build
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.model['name'])),
      body: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.model['name'],
                  style: const TextStyle(
                      fontSize: 28, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Text(widget.model['description'],
                  style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
              const Text('Pros:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.greenPrimary)),
              ...widget.model['pros'].map<Widget>((pro) => ListTile(
                    leading: const Icon(Icons.check_circle,
                        color: ColorManager.greenPrimary),
                    title: Text(pro),
                  )),
              const SizedBox(height: 10),
              const Text('Cons:',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: ColorManager.greenPrimary)),
              ...widget.model['cons'].map<Widget>((con) => ListTile(
                    leading: const Icon(Icons.cancel, color: Colors.red),
                    title: Text(con),
                  )),
              const Spacer(),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
        color: Colors.black87,
        width: double.infinity,
        height: 60,
        child: TextButton(
          onPressed: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('${widget.model['name']} selected as active model')),
            );
          },
          child: Text(
            'Switch to this Model',
            style: GoogleFonts.poppins(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
