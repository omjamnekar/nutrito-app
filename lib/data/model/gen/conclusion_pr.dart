class ConclusionPromptManger {
  ConclusionData? conclusionData;

  ConclusionPromptManger({this.conclusionData});

  ConclusionPromptManger.fromJson(Map<String, dynamic> json) {
    conclusionData = json['conclusionData'] != null
        ? ConclusionData.fromJson(json['conclusionData'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (conclusionData != null) {
      data['conclusionData'] = conclusionData!.toJson();
    }
    return data;
  }
}

class ConclusionData {
  String? allergenInformation;
  String? conclusion;
  String? overallHealthRating;
  String? recommendations;
  String? servingSize;

  ConclusionData(
      {this.allergenInformation,
      this.conclusion,
      this.overallHealthRating,
      this.recommendations,
      this.servingSize});

  ConclusionData.fromJson(Map<String, dynamic> json) {
    allergenInformation = json['allergenInformation'];
    conclusion = json['conclusion'];
    overallHealthRating = json['overallHealthRating'];
    recommendations = json['recommendations'];
    servingSize = json['servingSize'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allergenInformation'] = allergenInformation;
    data['conclusion'] = conclusion;
    data['overallHealthRating'] = overallHealthRating;
    data['recommendations'] = recommendations;
    data['servingSize'] = servingSize;
    return data;
  }
}
