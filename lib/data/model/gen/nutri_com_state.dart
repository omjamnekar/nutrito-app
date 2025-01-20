import 'dart:io';

import 'package:nutrito/data/model/gen/com.dart';

class NutriComState {
  GenNutrilizationResponse? genNutrilizationResponse;
  File? fileImage;

  NutriComState({
    required this.genNutrilizationResponse,
    required this.fileImage,
  });
}
