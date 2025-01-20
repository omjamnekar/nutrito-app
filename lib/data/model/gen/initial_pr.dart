class InitialPromptManager {
  InitialData? initialData;

  InitialPromptManager({this.initialData});

  InitialPromptManager.fromJson(Map<String, dynamic> json) {
    initialData = json['initialData'] != null
        ? InitialData.fromJson(json['initialData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (initialData != null) {
      data['initialData'] = initialData!.toJson();
    }
    return data;
  }
}

class InitialData {
  dynamic additionalInformation;
  String? allergenInformation;
  String? barcode;
  List<String>? certifications;
  String? countryOfOrigin;
  String? dietaryInformation;
  String? expiryDate;
  List<Ingredients>? ingredients;
  bool? isAddictive;
  String? link;
  Manufacturer? manufacturer;
  String? name;
  NutritionalInformation? nutritionalInformation;
  String? price;
  String? productType;
  String? servingSize;
  String? storageInstructions;
  String? usageInstructions;
  String? warnings;
  String? website;
  String? weight;

  InitialData({
    this.additionalInformation,
    this.allergenInformation,
    this.barcode,
    this.certifications,
    this.countryOfOrigin,
    this.dietaryInformation,
    this.expiryDate,
    this.ingredients,
    this.isAddictive,
    this.link,
    this.manufacturer,
    this.name,
    this.nutritionalInformation,
    this.price,
    this.productType,
    this.servingSize,
    this.storageInstructions,
    this.usageInstructions,
    this.warnings,
    this.website,
    this.weight,
  });

  InitialData.fromJson(Map<String, dynamic> json) {
    additionalInformation = json['additionalInformation'];
    allergenInformation = json['allergenInformation'];
    barcode = json['barcode'];
    certifications = json['certifications'] != null
        ? List<String>.from(json['certifications'])
        : null;
    countryOfOrigin = json['countryOfOrigin'];
    dietaryInformation = json['dietaryInformation'];
    expiryDate = json['expiryDate'];
    ingredients = json['ingredients'] != null
        ? (json['ingredients'] as List)
            .map((v) => Ingredients.fromJson(v))
            .toList()
        : null;
    isAddictive = json['isAddictive'];
    link = json['link'];
    manufacturer = json['manufacturer'] != null
        ? Manufacturer.fromJson(json['manufacturer'])
        : null;
    name = json['name'];
    nutritionalInformation = json['nutritionalInformation'] != null
        ? NutritionalInformation.fromJson(json['nutritionalInformation'])
        : null;
    price = json['price'];
    productType = json['productType'];
    servingSize = json['servingSize'];
    storageInstructions = json['storageInstructions'];
    usageInstructions = json['usageInstructions'];
    warnings = json['warnings'];
    website = json['website'];
    weight = json['weight'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['additionalInformation'] = additionalInformation;
    data['allergenInformation'] = allergenInformation;
    data['barcode'] = barcode;
    if (certifications != null) {
      data['certifications'] = certifications;
    }
    data['countryOfOrigin'] = countryOfOrigin;
    data['dietaryInformation'] = dietaryInformation;
    data['expiryDate'] = expiryDate;
    if (ingredients != null) {
      data['ingredients'] = ingredients!.map((v) => v.toJson()).toList();
    }
    data['isAddictive'] = isAddictive;
    data['link'] = link;
    if (manufacturer != null) {
      data['manufacturer'] = manufacturer!.toJson();
    }
    data['name'] = name;
    if (nutritionalInformation != null) {
      data['nutritionalInformation'] = nutritionalInformation!.toJson();
    }
    data['price'] = price;
    data['productType'] = productType;
    data['servingSize'] = servingSize;
    data['storageInstructions'] = storageInstructions;
    data['usageInstructions'] = usageInstructions;
    data['warnings'] = warnings;
    data['website'] = website;
    data['weight'] = weight;
    return data;
  }
}

class Ingredients {
  String? name;
  String? quantity;

  Ingredients({this.name, this.quantity});

  Ingredients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['quantity'] = quantity;
    return data;
  }
}

class Manufacturer {
  String? address;
  String? name;

  Manufacturer({this.address, this.name});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['address'] = address;
    data['name'] = name;
    return data;
  }
}

class NutritionalInformation {
  Map<String, String>? nutrients;

  NutritionalInformation({this.nutrients});

  NutritionalInformation.fromJson(Map<String, dynamic> json) {
    nutrients = json.map((key, value) => MapEntry(key, value.toString()));
  }

  Map<String, dynamic> toJson() {
    return nutrients ?? {};
  }
}
