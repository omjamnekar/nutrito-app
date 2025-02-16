import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class CompareManager {
  String? id;
  File? file1;
  File? file2;
  CompareProducts? compareProducts;
  Timestamp timestamp = Timestamp.now();

  CompareManager(
      {String? id,
      required this.file1,
      required this.file2,
      this.compareProducts})
      : id = id ?? Uuid().v4();

  CompareManager.fromJson(Map<String, dynamic> json) {
    file1 = json["file1"] != null ? File(json["file1"]) : null;
    file2 = json["file2"] != null ? File(json["file2"]) : null;

    compareProducts = json['compareProducts'] != null
        ? CompareProducts.fromJson(json['compareProducts'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (compareProducts != null) {
      data['compareProducts'] = compareProducts!.toJson();
    }
    if (file1 != null) {
      data['file1'] = file1!.path;
    }
    if (file2 != null) {
      data['file2'] = file2!.path;
    }
    data['timestamp'] = timestamp;
    data['id'] = id;
    return data;
  }
}

class CompareProducts {
  ComparisonSummary? comparisonSummary;
  Product? product1;
  Product? product2;
  String? startingComment;

  CompareProducts({
    this.comparisonSummary,
    this.product1,
    this.product2,
    this.startingComment,
  });

  CompareProducts.fromJson(Map<String, dynamic> json) {
    comparisonSummary = json['comparisonSummary'] != null
        ? ComparisonSummary.fromJson(json['comparisonSummary'])
        : null;
    try {
      product1 =
          json['product1'] != null ? Product.fromJson(json['product1']) : null;
      product2 =
          json['product2'] != null ? Product.fromJson(json['product2']) : null;
    } catch (e) {
      print('Error parsing products: $e');
      print('product1 raw data: ${json['product1']}');
      print('product2 raw data: ${json['product2']}');
    }
    startingComment = json['starting_comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (comparisonSummary != null) {
      data['comparisonSummary'] = comparisonSummary!.toJson();
    }
    if (product1 != null) {
      data['product1'] = product1!.toJson();
    }
    if (product2 != null) {
      data['product2'] = product2!.toJson();
    }
    data['starting_comment'] = startingComment;
    return data;
  }
}

class ComparisonSummary {
  List<KeyDifferences>? keyDifferences;
  List<KeySimilarities>? keySimilarities;
  String? overallComparisonConclusion;

  ComparisonSummary({
    this.keyDifferences,
    this.keySimilarities,
    this.overallComparisonConclusion,
  });

  ComparisonSummary.fromJson(Map<String, dynamic> json) {
    if (json['keyDifferences'] != null) {
      keyDifferences = (json['keyDifferences'] as List)
          .map((v) => KeyDifferences.fromJson(v))
          .toList();
    }
    if (json['keySimilarities'] != null) {
      keySimilarities = (json['keySimilarities'] as List)
          .map((v) => KeySimilarities.fromJson(v))
          .toList();
    }
    overallComparisonConclusion = json['overallComparisonConclusion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (keyDifferences != null) {
      data['keyDifferences'] = keyDifferences!.map((v) => v.toJson()).toList();
    }
    if (keySimilarities != null) {
      data['keySimilarities'] =
          keySimilarities!.map((v) => v.toJson()).toList();
    }
    data['overallComparisonConclusion'] = overallComparisonConclusion;
    return data;
  }
}

class KeyDifferences {
  String? aspect;
  String? product1;
  String? product2;

  KeyDifferences({this.aspect, this.product1, this.product2});

  KeyDifferences.fromJson(Map<String, dynamic> json) {
    aspect = json['aspect'];
    product1 = json['product1'];
    product2 = json['product2'];
  }

  Map<String, dynamic> toJson() {
    return {
      'aspect': aspect,
      'product1': product1,
      'product2': product2,
    };
  }
}

class KeySimilarities {
  String? aspect;
  String? value;

  KeySimilarities({this.aspect, this.value});

  KeySimilarities.fromJson(Map<String, dynamic> json) {
    aspect = json['aspect'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    return {
      'aspect': aspect,
      'value': value,
    };
  }
}

class Product {
  String? additionalInformation;
  String? allergenInformation;
  String? certifications;
  String? composition;
  String? customerRatings;
  String? dietarySuitability;
  String? manufacturer;
  String? name;
  NutritionalInformation? nutritionalInformation;
  String? packaging;
  String? price;
  String? sustainabilityScore;

  Product({
    this.additionalInformation,
    this.allergenInformation,
    this.certifications,
    this.composition,
    this.customerRatings,
    this.dietarySuitability,
    this.manufacturer,
    this.name,
    this.nutritionalInformation,
    this.packaging,
    this.price,
    this.sustainabilityScore,
  });

  Product.fromJson(dynamic json) {
    if (json is Map<String, dynamic>) {
      additionalInformation = json['AdditionalInformation'];
      allergenInformation = json['AllergenInformation'];
      certifications = json['Certifications'];
      composition = json['Composition'];
      customerRatings = json['CustomerRatings'];
      dietarySuitability = json['DietarySuitability'];
      manufacturer = json['Manufacturer'];
      name = json['Name'];
      nutritionalInformation = json['NutritionalInformation'] != null
          ? NutritionalInformation.fromJson(json['NutritionalInformation'])
          : null;
      packaging = json['Packaging'];
      price = json['Price'];
      sustainabilityScore = json['SustainabilityScore'];
    } else {
      throw ArgumentError('Expected a Map<String, dynamic>, got $json');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['AdditionalInformation'] = additionalInformation;
    data['AllergenInformation'] = allergenInformation;
    data['Certifications'] = certifications;
    data['Composition'] = composition;
    data['CustomerRatings'] = customerRatings;
    data['DietarySuitability'] = dietarySuitability;
    data['Manufacturer'] = manufacturer;
    data['Name'] = name;
    if (nutritionalInformation != null) {
      data['NutritionalInformation'] = nutritionalInformation!.toJson();
    }
    data['Packaging'] = packaging;
    data['Price'] = price;
    data['SustainabilityScore'] = sustainabilityScore;
    return data;
  }
}

class NutritionalInformation {
  Per100g? per100g;

  NutritionalInformation({this.per100g});

  NutritionalInformation.fromJson(Map<String, dynamic> json) {
    per100g =
        json['per100g'] != null ? Per100g.fromJson(json['per100g']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (per100g != null) {
      data['per100g'] = per100g!.toJson();
    }
    return data;
  }
}

class Per100g {
  String? carbohydrate;
  String? energy;
  String? fat;
  String? iron;
  String? protein;
  String? saturatedFat;
  String? sodium;
  String? sugar;

  Per100g({
    this.carbohydrate,
    this.energy,
    this.fat,
    this.iron,
    this.protein,
    this.saturatedFat,
    this.sodium,
    this.sugar,
  });

  Per100g.fromJson(Map<String, dynamic> json) {
    carbohydrate = json['Carbohydrate'];
    energy = json['Energy'];
    fat = json['Fat'];
    iron = json['Iron'];
    protein = json['Protein'];
    saturatedFat = json['SaturatedFat'];
    sodium = json['Sodium'];
    sugar = json['Sugar'];
  }

  Map<String, dynamic> toJson() {
    return {
      'Carbohydrate': carbohydrate,
      'Energy': energy,
      'Fat': fat,
      'Iron': iron,
      'Protein': protein,
      'SaturatedFat': saturatedFat,
      'Sodium': sodium,
      'Sugar': sugar,
    };
  }
}
