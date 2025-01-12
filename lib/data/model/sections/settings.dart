class SettingSetupManager {
  final Profile? profile;
  final Scans? scans;
  final Settings? settings;
  final Goals? goals;

  SettingSetupManager({
    required this.profile,
    required this.scans,
    required this.settings,
    required this.goals,
  });

  factory SettingSetupManager.fromMap(Map<String, dynamic> map) {
    return SettingSetupManager(
      profile: Profile.fromMap(map['profile'] ?? {}),
      scans: Scans.fromMap(map['scans'] ?? {}),
      settings: Settings.fromMap(map['settings'] ?? {}),
      goals: Goals.fromMap(map['goals'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profile': profile?.toMap() ?? {},
      'scans': scans?.toMap() ?? {},
      'settings': settings?.toMap() ?? {},
      'goals': goals?.toMap() ?? {},
    };
  }
}

class Profile {
  final Section_1? section_1;

  Profile({required this.section_1});

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      section_1: Section_1?.fromMap(map['section_1'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'section_1': section_1?.toMap() ?? {},
    };
  }
}

class Section_1 {
  final String? avatar;
  final String? username;
  final String? email;
  final DiataryIntake? diataryIntake;
  final HealthScore? healthScore;
  final NutrientDeficiencies? nutrientDeficiencies;
  final Weight? weight;
  final Weight? weightLoss;
  final NutriScore? nutriScore;
  final List<Group>? groups;
  final ProfileAccess profileAccess;

  Section_1({
    required this.avatar,
    required this.username,
    required this.email,
    required this.diataryIntake,
    required this.healthScore,
    required this.nutrientDeficiencies,
    required this.weight,
    required this.weightLoss,
    required this.nutriScore,
    required this.groups,
    required this.profileAccess,
  });

  factory Section_1.fromMap(Map<String, dynamic> map) {
    return Section_1(
      avatar: map['avatar'] ?? "",
      username: map['username'] ?? "",
      email: map['email'] ?? "",
      diataryIntake: DiataryIntake.fromMap(map['diataryIntake'] ?? {}),
      healthScore: HealthScore.fromMap(map['healthScore'] ?? {}),
      nutrientDeficiencies:
          NutrientDeficiencies.fromMap(map['nutrientDeficiencies'] ?? {}),
      weight: Weight.fromMap(map['weight'] ?? {}),
      weightLoss: Weight.fromMap(map['weightLoss'] ?? {}),
      nutriScore: NutriScore.fromMap(map['nutriScore'] ?? {}),
      groups: List<Group>.from(
          map['groups']?.map((x) => Group.fromMap(x ?? {})) ?? {}),
      profileAccess: ProfileAccess.fromMap(map['profileAccess'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'avatar': avatar ?? "",
      'username': username ?? "",
      'email': email ?? "",
      'diataryIntake': diataryIntake?.toMap() ?? {},
      'healthScore': healthScore?.toMap() ?? {},
      'nutrientDeficiencies': nutrientDeficiencies?.toMap() ?? {},
      'weight': weight?.toMap() ?? {},
      'weightLoss': weightLoss?.toMap() ?? {},
      'nutriScore': nutriScore?.toMap() ?? {},
      'groups': groups?.map((x) => x.toMap()).toList() ?? [],
      'profileAccess': profileAccess.toMap() ?? {},
    };
  }
}

class DiataryIntake {
  final int? numb;
  final String? type;

  DiataryIntake({required this.numb, required this.type});

  factory DiataryIntake.fromMap(Map<String, dynamic> map) {
    return DiataryIntake(
      numb: map['numb'] ?? 0,
      type: map['type'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numb': numb ?? 0,
      'type': type ?? "",
    };
  }
}

class HealthScore {
  final int? numb;
  final String? type;

  HealthScore({required this.numb, required this.type});

  factory HealthScore.fromMap(Map<String, dynamic> map) {
    return HealthScore(
      numb: map['numb'] ?? 0,
      type: map['type'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numb': numb ?? 0,
      'type': type ?? "",
    };
  }
}

class NutrientDeficiencies {
  final String? state;

  NutrientDeficiencies({required this.state});

  factory NutrientDeficiencies.fromMap(Map<String, dynamic> map) {
    return NutrientDeficiencies(
      state: map['state'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'state': state ?? "",
    };
  }
}

class Weight {
  final int? numb;
  final String? type;

  Weight({required this.numb, required this.type});

  factory Weight.fromMap(Map<String, dynamic> map) {
    return Weight(
      numb: map['numb'] ?? 0,
      type: map['type'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numb': numb ?? 0,
      'type': type ?? "",
    };
  }
}

class NutriScore {
  final int? numb;
  final String? grade;
  final String? type;

  NutriScore({required this.numb, required this.grade, required this.type});

  factory NutriScore.fromMap(Map<String, dynamic> map) {
    return NutriScore(
      numb: map['numb'] ?? 0,
      grade: map['grade'] ?? "",
      type: map['type'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'numb': numb ?? 0,
      'grade': grade ?? "",
      'type': type ?? "s",
    };
  }
}

class Group {
  final String? group;

  Group({required this.group});

  factory Group.fromMap(Map<String, dynamic> map) {
    return Group(
      group: map['group'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'group': group ?? "",
    };
  }
}

class ProfileAccess {
  final List<String?> options;
  final String? access;

  ProfileAccess({required this.options, required this.access});

  factory ProfileAccess.fromMap(Map<String, dynamic> map) {
    return ProfileAccess(
      options: List<String>.from(map['options'] ?? ""),
      access: map['access'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'options': options ?? [],
      'access': access ?? "",
    };
  }
}

// Define other classes such as Scans, Settings, and Goals similarly
// This is a partial implementation focusing on the `profile` section

class Scans {
  final HealthRating? healthRating;
  final bool? allergenAlert;
  final bool? alternativeSuggestion;
  final bool? balancedMeal;
  final bool? expiryAlert;
  final ScanModeSettings? scanModeSettings;

  Scans({
    required this.healthRating,
    required this.allergenAlert,
    required this.alternativeSuggestion,
    required this.balancedMeal,
    required this.expiryAlert,
    required this.scanModeSettings,
  });

  factory Scans.fromMap(Map<String, dynamic> map) {
    return Scans(
      healthRating: HealthRating.fromMap(map['healthRating'] ?? {}),
      allergenAlert: map['allergen Alert'] ?? false,
      alternativeSuggestion: map['alternativeSuggestion'] ?? false,
      balancedMeal: map['balanacedMeal'] ?? false,
      expiryAlert: map['expiryAlert'] ?? false,
      scanModeSettings: ScanModeSettings.fromMap(map['scanModeSettings'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'healthRating': healthRating?.toMap() ?? {},
      'allergen Alert': allergenAlert ?? false,
      'alternativeSuggestion': alternativeSuggestion ?? false,
      'balanacedMeal': balancedMeal ?? false,
      'expiryAlert': expiryAlert ?? false,
      'scanModeSettings': scanModeSettings?.toMap() ?? {},
    };
  }
}

class HealthRating {
  final List<String?> range;
  final String? selected;

  HealthRating({required this.range, required this.selected});

  factory HealthRating.fromMap(Map<String, dynamic> map) {
    return HealthRating(
      range: List<String>.from(map['range'] ?? ""),
      selected: map['selected'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'range': range ?? [],
      'selected': selected ?? "",
    };
  }
}

class ScanModeSettings {
  final List<String?>? range;
  final String? selected;

  ScanModeSettings({required this.range, required this.selected});

  factory ScanModeSettings.fromMap(Map<String, dynamic> map) {
    return ScanModeSettings(
      range: List<String>.from(map['range'] ?? "") ?? [],
      selected: map['selected'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'range': range ?? [],
      'selected': selected ?? "",
    };
  }
}

/////////////////////////////////////////////////
//
class Settings {
  final AppSettings? appSettings;
  final Access? access;
  final Services? services;

  Settings({
    required this.appSettings,
    required this.access,
    required this.services,
  });

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      appSettings: AppSettings.fromMap(map['appSettings'] ?? {}),
      access: Access.fromMap(map['access'] ?? {}),
      services: Services.fromMap(map['services'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'appSettings': appSettings?.toMap() ?? {},
      'access': access?.toMap() ?? {},
      'services': services?.toMap() ?? {},
    };
  }
}

class AppSettings {
  final Map<String, dynamic>? nutrientionSettings;
  final Map<String, dynamic>? themeAppearance;
  final Map<String, dynamic>? accuracy;
  final Map<String, dynamic>? supportedLanguage;
  final Map<String, dynamic>? storageManagement;

  AppSettings({
    required this.nutrientionSettings,
    required this.themeAppearance,
    required this.accuracy,
    required this.supportedLanguage,
    required this.storageManagement,
  });

  factory AppSettings.fromMap(Map<String, dynamic> map) {
    return AppSettings(
      nutrientionSettings:
          Map<String, dynamic>.from(map['nutrientionSettings'] ?? {}),
      themeAppearance: Map<String, dynamic>.from(map['themeAppearance'] ?? {}),
      accuracy: Map<String, dynamic>.from(map['accuracy'] ?? {}),
      supportedLanguage:
          Map<String, dynamic>.from(map['supportedLanguage'] ?? {}),
      storageManagement:
          Map<String, dynamic>.from(map['storageManagement'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nutrientionSettings': nutrientionSettings ?? {},
      'themeAppearance': themeAppearance ?? {},
      'accuracy': accuracy ?? {},
      'supportedLanguage': supportedLanguage ?? {},
      'storageManagement': storageManagement ?? {},
    };
  }
}

class Access {
  final Map<String, dynamic>? purchaseHistory;
  final Map<String, dynamic>? socialMediaIntegration;
  final Map<String, dynamic>? appUpdates;
  final Map<String, dynamic>? subscriptionManagement;
  final Map<String, dynamic>? dataUsage;

  Access({
    required this.purchaseHistory,
    required this.socialMediaIntegration,
    required this.appUpdates,
    required this.subscriptionManagement,
    required this.dataUsage,
  });

  factory Access.fromMap(Map<String, dynamic> map) {
    return Access(
      purchaseHistory: Map<String, dynamic>.from(map['purchaseHistory'] ?? {}),
      socialMediaIntegration:
          Map<String, dynamic>.from(map['socialMediaIntegration'] ?? {}),
      appUpdates: Map<String, dynamic>.from(map['appUpdates'] ?? {}),
      subscriptionManagement:
          Map<String, dynamic>.from(map['subscriptionManagement'] ?? {}),
      dataUsage: Map<String, dynamic>.from(map['dataUsage'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'purchaseHistory': purchaseHistory ?? {},
      'socialMediaIntegration': socialMediaIntegration ?? {},
      'appUpdates': appUpdates ?? {},
      'subscriptionManagement': subscriptionManagement ?? {},
      'dataUsage': dataUsage ?? {},
    };
  }
}

class Services {
  final Map<String, dynamic>? privacyPolicy;
  final Map<String, dynamic>? feedback;
  final Map<String, dynamic>? termsOfService;
  final Map<String, dynamic>? appVersion;

  Services({
    required this.privacyPolicy,
    required this.feedback,
    required this.termsOfService,
    required this.appVersion,
  });

  factory Services.fromMap(Map<String, dynamic> map) {
    return Services(
      privacyPolicy: Map<String, dynamic>.from(map['privacyPolicy'] ?? {}),
      feedback: Map<String, dynamic>.from(map['Feedback'] ?? {}),
      termsOfService: Map<String, dynamic>.from(map['termsOfService'] ?? {}),
      appVersion: Map<String, dynamic>.from(map['appVersion'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'privacyPolicy': privacyPolicy ?? {},
      'Feedback': feedback ?? {},
      'termsOfService': termsOfService ?? {},
      'appVersion': appVersion ?? {},
    };
  }
}

////////////////////////////////////////////////////////
///

class Goals {
  final Section1? section1;
  final Section2? section2;

  Goals({required this.section1, required this.section2});

  factory Goals.fromMap(Map<String, dynamic> map) {
    return Goals(
      section1: Section1.fromMap(map['section1'] ?? {}),
      section2: Section2.fromMap(map['section2'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'section1': section1?.toMap() ?? {},
      'section2': section2?.toMap() ?? {},
    };
  }
}

class Section1 {
  final UserGoalManagement? userGoalManagement;
  final FoodProductAnalysis? foodProductAnalysis;
  final FoodProductConclusion? foodProductConclusion;

  Section1({
    required this.userGoalManagement,
    required this.foodProductAnalysis,
    required this.foodProductConclusion,
  });

  factory Section1.fromMap(Map<String, dynamic> map) {
    return Section1(
      userGoalManagement:
          UserGoalManagement.fromMap(map['userGoalManagement'] ?? {}),
      foodProductAnalysis:
          FoodProductAnalysis.fromMap(map['foodProductAnalysis'] ?? {}),
      foodProductConclusion:
          FoodProductConclusion.fromMap(map['foodProductConclusion'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userGoalManagement': userGoalManagement?.toMap() ?? {},
      'foodProductAnalysis': foodProductAnalysis?.toMap() ?? {},
      'foodProductConclusion': foodProductConclusion?.toMap() ?? {},
    };
  }
}

class UserGoalManagement {
  final GoalCategories? goalCategories;
  final Map<String, dynamic>? customGoals;
  final Map<String, dynamic>? aiRecommendations;

  UserGoalManagement({
    required this.goalCategories,
    required this.customGoals,
    required this.aiRecommendations,
  });

  factory UserGoalManagement.fromMap(Map<String, dynamic> map) {
    return UserGoalManagement(
      goalCategories: GoalCategories.fromMap(map['goalCategories'] ?? {}),
      customGoals: Map<String, dynamic>.from(map['customGoals'] ?? {}),
      aiRecommendations:
          Map<String, dynamic>.from(map['Ai Recommendations'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goalCategories': goalCategories?.toMap() ?? {},
      'customGoals': customGoals ?? {},
      'Ai Recommendations': aiRecommendations ?? {},
    };
  }
}

class GoalCategories {
  final List<String>? range;
  final String? selected;

  GoalCategories({required this.range, required this.selected});

  factory GoalCategories.fromMap(Map<String, dynamic> map) {
    return GoalCategories(
      range: List<String>.from(map['range'] ?? {}) ?? [],
      selected: map['selected'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'range': range ?? [],
      'selected': selected ?? "",
    };
  }
}

class FoodProductAnalysis {
  final Map<String, dynamic>? mlModel;

  FoodProductAnalysis({required this.mlModel});

  factory FoodProductAnalysis.fromMap(Map<String, dynamic> map) {
    return FoodProductAnalysis(
      mlModel: Map<String, dynamic>.from(map['mlModel'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mlModel': mlModel ?? {},
    };
  }
}

class FoodProductConclusion {
  final Map<String, dynamic>? goalAlignmentReport;
  final Map<String, dynamic>? instantAlerts;

  FoodProductConclusion({
    required this.goalAlignmentReport,
    required this.instantAlerts,
  });

  factory FoodProductConclusion.fromMap(Map<String, dynamic> map) {
    return FoodProductConclusion(
      goalAlignmentReport:
          Map<String, dynamic>.from(map['goalAligmentReport'] ?? {}),
      instantAlerts: Map<String, dynamic>.from(map['instantAlerts'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goalAligmentReport': goalAlignmentReport ?? {},
      'instantAlerts': instantAlerts ?? {},
    };
  }
}

class Section2 {
  final HealthDataRecordingAndVisualization?
      healthDataRecordingAndVisualization;
  final Other? other;

  Section2({
    required this.healthDataRecordingAndVisualization,
    required this.other,
  });

  factory Section2.fromMap(Map<String, dynamic> map) {
    return Section2(
      healthDataRecordingAndVisualization:
          HealthDataRecordingAndVisualization.fromMap(
              map['healthDataRecordingAndVisualization']),
      other: Other.fromMap(map['other']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'healthDataRecordingAndVisualization':
          healthDataRecordingAndVisualization?.toMap() ?? {},
      'other': other?.toMap() ?? {},
    };
  }
}

class HealthDataRecordingAndVisualization {
  final Map<String, dynamic>? healthMetricsTracking;
  final Map<String, dynamic>? habitInsights;
  final Map<String, dynamic>? periodicReports;
  final Map<String, dynamic>? integrationWithWearables;

  HealthDataRecordingAndVisualization({
    required this.healthMetricsTracking,
    required this.habitInsights,
    required this.periodicReports,
    required this.integrationWithWearables,
  });

  factory HealthDataRecordingAndVisualization.fromMap(
      Map<String, dynamic> map) {
    return HealthDataRecordingAndVisualization(
      healthMetricsTracking:
          Map<String, dynamic>.from(map['healthMericsTracking'] ?? {}),
      habitInsights: Map<String, dynamic>.from(map['habitInsights'] ?? {}),
      periodicReports: Map<String, dynamic>.from(map['periodicReports'] ?? {}),
      integrationWithWearables:
          Map<String, dynamic>.from(map['integrationWithWearables'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'healthMericsTracking': healthMetricsTracking ?? {},
      'habitInsights': habitInsights ?? {},
      'periodicReports': periodicReports ?? {},
      'integrationWithWearables': integrationWithWearables ?? {},
    };
  }
}

class Other {
  final Map<String, dynamic>? recipeSuggestions;
  final Map<String, dynamic>? mealPlanning;

  Other({required this.recipeSuggestions, required this.mealPlanning});

  factory Other.fromMap(Map<String, dynamic> map) {
    return Other(
      recipeSuggestions:
          Map<String, dynamic>.from(map['recipeSuggestions'] ?? {}),
      mealPlanning: Map<String, dynamic>.from(map['mealPlanning'] ?? {}),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipeSuggestions': recipeSuggestions ?? {},
      'mealPlanning': mealPlanning ?? {},
    };
  }
}
