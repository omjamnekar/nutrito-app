import 'dart:io';

import 'package:nutrito/data/model/gen/compare/compare.dart';

class CompareComboManager {
  CompareManager? compareManager;
  Map<String, File> files;

  CompareComboManager({required this.compareManager, required this.files});

  factory CompareComboManager.fromJson(Map<String, dynamic> json) {
    return CompareComboManager(
      compareManager: CompareManager.fromJson(json['compareProducts']),
      files: (json['files'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, File(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'compareProducts': compareManager?.toJson() ?? {},
      'files': files.map((key, value) => MapEntry(key, value.path)),
    };
  }
}
