import 'package:flutter/material.dart';
import 'package:nutrito/util/theme/color.dart';

class PersonalizeConPage extends StatefulWidget {
  const PersonalizeConPage({super.key});

  @override
  _PersonalizeConPageState createState() => _PersonalizeConPageState();
}

class _PersonalizeConPageState extends State<PersonalizeConPage> {
  late TextEditingController _responseController;
  Map<String, bool> responseTypes = {
    'Reasoning': false,
    'Web Search': false,
    'Analytical View': false,
    'Summarized Output': false,
  };

  @override
  void initState() {
    super.initState();
    _responseController = TextEditingController();
  }

  @override
  void dispose() {
    _responseController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    final editedResponse = _responseController.text;
    final selectedTypes = responseTypes.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();

    print('Edited Response: $editedResponse');
    print('Selected Response Types: $selectedTypes');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully!')),
    );
  }

  void _addCustomType() {
    TextEditingController customTypeController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Custom Response Type'),
          content: TextField(
            controller: customTypeController,
            decoration: const InputDecoration(hintText: 'Enter new type'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final newType = customTypeController.text;
                if (newType.isNotEmpty) {
                  setState(() {
                    responseTypes[newType] = false;
                  });
                }
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personalize Model Response'),
        backgroundColor: ColorManager.bluePrimary.withOpacity(0.2),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveChanges,
          ),
        ],
      ),
      body: Container(
        color: ColorManager.bluePrimary.withOpacity(0.01),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Edit Model Output:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _responseController,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Edit the response here...',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Select Response Types:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: responseTypes.entries.map((entry) {
                  return CheckboxListTile(
                    title: Text(entry.key),
                    value: entry.value,
                    activeColor: ColorManager.bluePrimary,
                    onChanged: (bool? newValue) {
                      setState(() {
                        responseTypes[entry.key] = newValue ?? false;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.black87,
                ),
                onPressed: _addCustomType,
                icon: const Icon(Icons.add),
                label: const Text('Add Custom Type'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
