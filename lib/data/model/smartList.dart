import 'package:uuid/uuid.dart';

class Products {
  String? id;
  String product;
  num quantity; //kg
  Products({
    String? id,
    required this.product,
    required this.quantity,
  }) : id = id ?? Uuid().v4();
}
