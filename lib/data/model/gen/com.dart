import 'package:nutrito/data/model/gen/conclusion_pr.dart';
import 'package:nutrito/data/model/gen/health_pr.dart';
import 'package:nutrito/data/model/gen/initial_pr.dart';
import 'package:nutrito/data/model/gen/ratio_pr.dart';

class GenNutrilizationResponse {
  InitialPromptManager? initialPromptManager;
  HealthPromptManager? healthPromptManager;
  RatioPromptManager? ratioPromptManager;
  ConclusionPromptManger? conclusionPromptManger;

  GenNutrilizationResponse({
    required this.initialPromptManager,
    required this.healthPromptManager,
    required this.ratioPromptManager,
    required this.conclusionPromptManger,
  });

  Map<String, dynamic> toJson() {
    return {
      'initialPromptManager': initialPromptManager?.toJson(),
      'healthPromptManager': healthPromptManager?.toJson(),
      'ratioPromptManager': ratioPromptManager?.toJson(),
      'conclusionPromptManger': conclusionPromptManger?.toJson(),
    };
  }

  factory GenNutrilizationResponse.fromJson(Map<String, dynamic> json) {
    return GenNutrilizationResponse(
      initialPromptManager: json['initialPromptManager'] != null
          ? InitialPromptManager.fromJson(json['initialPromptManager'])
          : null,
      healthPromptManager: json['healthPromptManager'] != null
          ? HealthPromptManager.fromJson(json['healthPromptManager'])
          : null,
      ratioPromptManager: json['ratioPromptManager'] != null
          ? RatioPromptManager.fromJson(json['ratioPromptManager'])
          : null,
      conclusionPromptManger: json['conclusionPromptManger'] != null
          ? ConclusionPromptManger.fromJson(json['conclusionPromptManger'])
          : null,
    );
  }
}
