import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/gen/compare/cam_com.dart';
import 'package:nutrito/data/model/gen/compare/compare.dart';

class CompareCurrntProvider extends StateNotifier<CompareComboManager> {
  CompareCurrntProvider()
      : super(CompareComboManager(
            compareManager: null,
            files: {"file1": File(""), "file2": File("")}));

  Future<void> setData(
      CompareManager response, File fileImage1, File fileImage2) async {
    state = CompareComboManager(
      compareManager: response,
      files: {"image1": fileImage1, "image2": fileImage2},
    );
  }

  CompareComboManager getState() {
    return state;
  }
}

final compareCurrntProvider = StateNotifierProvider(
  (ref) {
    return CompareCurrntProvider();
  },
);
