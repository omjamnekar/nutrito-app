import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/gen/com.dart';
import 'package:nutrito/data/model/gen/nutri_com_state.dart';

class NutrilizationCrrntProvider extends StateNotifier<NutriComState> {
  NutrilizationCrrntProvider()
      : super(NutriComState(genNutrilizationResponse: null, fileImage: null));

  Future<void> setData(
      GenNutrilizationResponse response, File fileImage) async {
    state =
        NutriComState(genNutrilizationResponse: response, fileImage: fileImage);
  }

  NutriComState getState() {
    return state;
  }
}

final nutrilizationCrrntProvider = StateNotifierProvider(
  (ref) {
    return NutrilizationCrrntProvider();
  },
);
