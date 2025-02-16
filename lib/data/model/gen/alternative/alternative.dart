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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['description'] = this.description;
    data['health_benefits'] = this.healthBenefits;
    data['common_uses'] = this.commonUses;
    data['image_url'] = this.imageUrl;
    data['company_name'] = this.companyName;
    data['price'] = this.price;
    data['qty'] = this.qty;
    return data;
  }
}
