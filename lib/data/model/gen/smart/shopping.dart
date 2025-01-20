class ShoppingItemManager {
  String? name;
  String? imageUrl;
  double? healthRate;
  String? description;
  List<String>? benefits;

  // Constructor
  ShoppingItemManager({
    this.name,
    this.imageUrl,
    this.healthRate,
    this.description,
    this.benefits,
  });

  // Named constructor to create an instance from JSON
  ShoppingItemManager.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "";
    imageUrl = json['imageurl'] ?? "";
    healthRate = json['healthRate'] ?? "";
    description = json['description'] ?? "";
    benefits = List<String>.from(json['benefits'] ?? []);
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['imageurl'] = imageUrl;
    data['healthRate'] = healthRate;
    data['description'] = description;
    data['benefits'] = benefits;
    return data;
  }
}
