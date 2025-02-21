import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/gen/alternative/alternative.dart';

class MongoResponse extends StateNotifier<List<AlthernativeModel>> {
  MongoResponse() : super([]);

  void setup(List<AlthernativeModel> model) {
    state = model;
  }

  List<AlthernativeModel> load() {
    return state;
  }
}

final mongoResponseProvider =
    StateNotifierProvider<MongoResponse, List<AlthernativeModel>>(
  (ref) {
    return MongoResponse();
  },
);
