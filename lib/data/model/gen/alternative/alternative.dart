class AlthernativeModel {
  String? name;
  String? description;
  List<String>? healthBenefits;
  List<String>? commonUses;
  String? imageUrl;
  String? companyName;
  int? price;
  String? qty;

  AlthernativeModel(
      {this.name,
      this.description,
      this.healthBenefits,
      this.commonUses,
      this.imageUrl,
      this.companyName,
      this.price,
      this.qty});

  AlthernativeModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    healthBenefits = json['health_benefits'].cast<String>();
    commonUses = json['common_uses'].cast<String>();
    imageUrl = json['image_url'];
    companyName = json['company_name'];
    price = json['price'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['health_benefits'] = healthBenefits;
    data['common_uses'] = commonUses;
    data['image_url'] = imageUrl;
    data['company_name'] = companyName;
    data['price'] = price;
    data['qty'] = qty;
    return data;
  }
}
