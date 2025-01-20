class HealthPromptManager {
  HealthConsideration? healthConsideration;

  HealthPromptManager({this.healthConsideration});

  HealthPromptManager.fromJson(Map<String, dynamic> json) {
    healthConsideration = json['healthConsideration'] != null
        ? HealthConsideration.fromJson(json['healthConsideration'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (healthConsideration != null) {
      data['healthConsideration'] = healthConsideration!.toJson();
    }
    return data;
  }
}

class HealthConsideration {
  List<HealthConsiderations>? healthConsiderations;

  HealthConsideration({this.healthConsiderations});

  HealthConsideration.fromJson(Map<String, dynamic> json) {
    if (json['health_considerations'] != null) {
      healthConsiderations = <HealthConsiderations>[];
      json['health_considerations'].forEach((v) {
        healthConsiderations!.add(HealthConsiderations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (healthConsiderations != null) {
      data['health_considerations'] =
          healthConsiderations!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class HealthConsiderations {
  String? ingredient;
  List<String>? negative;
  List<String>? positive; // Corrected the type to List<String>

  HealthConsiderations({this.ingredient, this.negative, this.positive});

  HealthConsiderations.fromJson(Map<String, dynamic> json) {
    ingredient = json['ingredient'];
    negative = json['negative']?.cast<String>();
    positive = json['positive']?.cast<String>(); // Corrected deserialization
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['ingredient'] = ingredient;
    data['negative'] = negative;
    data['positive'] = positive; // Corrected serialization
    return data;
  }
}
