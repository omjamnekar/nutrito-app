class RatioPromptManager {
  RatioSpecified? ratioSpecified;

  RatioPromptManager({this.ratioSpecified});

  RatioPromptManager.fromJson(Map<String, dynamic> json) {
    ratioSpecified = json['ratioSpecified'] != null
        ? RatioSpecified.fromJson(json['ratioSpecified'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (ratioSpecified != null) {
      data['ratioSpecified'] = ratioSpecified!.toJson();
    }
    return data;
  }
}

class RatioSpecified {
  List<IngredientAnalysis>? ingredientAnalysis;
  NutritionalAnalysis? nutritionalAnalysis;

  RatioSpecified({this.ingredientAnalysis, this.nutritionalAnalysis});

  RatioSpecified.fromJson(Map<String, dynamic> json) {
    if (json['ingredientAnalysis'] != null) {
      ingredientAnalysis = [];
      json['ingredientAnalysis'].forEach((v) {
        ingredientAnalysis!.add(IngredientAnalysis.fromJson(v));
      });
    }
    nutritionalAnalysis = json['nutritionalAnalysis'] != null
        ? NutritionalAnalysis.fromJson(json['nutritionalAnalysis'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (ingredientAnalysis != null) {
      data['ingredientAnalysis'] =
          ingredientAnalysis!.map((v) => v.toJson()).toList();
    }
    if (nutritionalAnalysis != null) {
      data['nutritionalAnalysis'] = nutritionalAnalysis!.toJson();
    }
    return data;
  }
}

class IngredientAnalysis {
  String? comment;
  int? healthRating; // 1-10 scale
  String? ingredient;

  IngredientAnalysis({this.comment, this.healthRating, this.ingredient});

  IngredientAnalysis.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    healthRating = json['healthRating'];
    ingredient = json['ingredient'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['comment'] = comment;
    data['healthRating'] = healthRating;
    data['ingredient'] = ingredient;
    return data;
  }
}

class NutritionalAnalysis {
  Map<String, NutritionalMetric>? metrics;

  NutritionalAnalysis({this.metrics});

  NutritionalAnalysis.fromJson(Map<String, dynamic> json) {
    metrics = {};
    json.forEach((key, value) {
      metrics![key] = NutritionalMetric.fromJson(value);
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    metrics?.forEach((key, value) {
      data[key] = value.toJson();
    });
    return data;
  }
}

class NutritionalMetric {
  int? feedbackRatio; // 1-10 scale
  String? value;

  NutritionalMetric({this.feedbackRatio, this.value});

  NutritionalMetric.fromJson(Map<String, dynamic> json) {
    feedbackRatio = json['feedbackRatio'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['feedbackRatio'] = feedbackRatio;
    data['value'] = value;
    return data;
  }
}
