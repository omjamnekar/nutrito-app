import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutrito/data/model/gen/smart/shopping.dart';
import 'package:uuid/uuid.dart';

class ComSmartList {
  List<SmartShoppingListManager> smartShoppingListManager;

  ComSmartList({
    required this.smartShoppingListManager,
  });

  factory ComSmartList.fromJson(Map<String, dynamic> json) {
    return ComSmartList(
      smartShoppingListManager: (json['smartShoppingListManager'] as List)
          .map((item) => SmartShoppingListManager.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'smartShoppingListManager':
          smartShoppingListManager.map((item) => item.toJson()).toList(),
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory ComSmartList.fromString(String source) {
    final json = jsonDecode(source) as Map<String, dynamic>;
    return ComSmartList.fromJson(json);
  }
}

class SmartShoppingListManager {
  String id;
  List<ShoppingItemManager> smartItems;
  List<ShoppingItemManager> cartItems;
  Timestamp timestamp;
  Timestamp setTime;
  String title;
  String description;

  SmartShoppingListManager({
    String? id,
    required this.title,
    required this.description,
    required this.smartItems,
    required this.cartItems,
    required this.timestamp,
    required this.setTime,
  }) : id = id ?? Uuid().v4();

  factory SmartShoppingListManager.fromJson(Map<String, dynamic> json) {
    return SmartShoppingListManager(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      smartItems: (json['smartItems'] as List)
          .map((item) => ShoppingItemManager.fromJson(item))
          .toList(),
      cartItems: (json['cartItems'] as List)
          .map((item) => ShoppingItemManager.fromJson(item))
          .toList(),
      timestamp: Timestamp.fromMillisecondsSinceEpoch(json['timestamp']),
      setTime: Timestamp.fromMillisecondsSinceEpoch(json['setTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'smartItems': smartItems.map((item) => item.toJson()).toList(),
      'cartItems': cartItems.map((item) => item.toJson()).toList(),
      'timestamp': timestamp.millisecondsSinceEpoch,
      'setTime': setTime.millisecondsSinceEpoch,
    };
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  factory SmartShoppingListManager.fromString(String source) {
    final json = jsonDecode(source) as Map<String, dynamic>;
    return SmartShoppingListManager.fromJson(json);
  }
}
