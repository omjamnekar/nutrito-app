import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/data/model/auth.dart';
import 'package:nutrito/data/model/sections/response_State.dart';
import 'package:nutrito/data/model/sections/settings.dart';
import 'package:nutrito/data/model/sections/user_state.dart';
import 'package:nutrito/data/repositories/registerUser.dart';
import 'package:nutrito/data/storage/user_Data.dart';

class PrimarySetupProvider extends StateNotifier<PrimarySetupManager> {
  PrimarySetupProvider()
      : super(
          PrimarySetupManager(
            id: "",
            settingSetupManager: null,
            homeSetupManager: HomeSetupManager(data: {}),
            socialSetupManager: SocialSetupManager(data: {}),
            searchSetupManager: SearchSetupManager(data: {}),
          ),
        );

  Future<ResponseStatus> setupPrimaryCourse() async {
    RegisterUser authSetupUser = RegisterUser();
    UserStore userStore = UserStore();
    InitialSetup initialSetup = InitialSetup();

    ResponseStatus response = await authSetupUser.requestUserRegister(
        await initialSetup.setupData(await userStore.loadData()).then(
      (value) {
        state = value;
        return state;
      },
    ));

    return response;
  }

  Future<ResponseStatus> setupPrimaryLoginCourse() async {
    RegisterUser authSetupUser = RegisterUser();
    UserStore userStore = UserStore();

    return await authSetupUser
        .requestUserLogin(await userStore.loadData())
        .then(
      (responseData) {
// call primarySetup and held data in state for w hole session
        // print(responseData["primarysetup"]["settings"]);
        // state = PrimarySetupManager(
        //   id: responseData["primarysetup"]["id"] ?? "",
        //   settingSetupManager: SettingSetupManager.fromMap(
        //       responseData["primarysetup"]["settings"] ?? {}),
        //   homeSetupManager: HomeSetupManager(
        //       data: responseData["primarysetup"]["home"] ?? {}),
        //   socialSetupManager: SocialSetupManager(
        //       data: responseData["primarysetup"]["social"] ?? {}),
        //   searchSetupManager: SearchSetupManager(data: {}),
        // );

        return responseData["response"];
      },
    );
  }
}

final primarySetupProvider =
    StateNotifierProvider<PrimarySetupProvider, PrimarySetupManager>(
  (ref) {
    return PrimarySetupProvider();
  },
);

class InitialSetup {
  Future<PrimarySetupManager> setupData(UserModel userModel) async {
    return PrimarySetupManager(
        id: userModel.id ?? "",
        homeSetupManager: HomeSetupManager(
          data: {},
        ),
        searchSetupManager: SearchSetupManager(
          data: {},
        ),
        socialSetupManager: SocialSetupManager(data: {}),
        settingSetupManager: SettingSetupManager(
          profile: Profile(
            section_1: Section_1(
              avatar: userModel.image ?? "",
              username: userModel.name ?? "",
              email: userModel.email,
              diataryIntake: DiataryIntake(numb: 2, type: "type"),
              healthScore: HealthScore(numb: 23, type: "type"),
              nutrientDeficiencies: NutrientDeficiencies(state: ""),
              weight: Weight(numb: 3, type: ""),
              weightLoss: Weight(numb: 3, type: ""),
              nutriScore: NutriScore(numb: 4, grade: "", type: "type"),
              groups: [Group(group: 'S')],
              profileAccess: ProfileAccess(options: [""], access: "access"),
            ),
          ),
          scans: Scans(
              healthRating: HealthRating(range: [""], selected: ""),
              allergenAlert: true,
              alternativeSuggestion: false,
              balancedMeal: false,
              expiryAlert: false,
              scanModeSettings: ScanModeSettings(range: [""], selected: "a")),
          settings: Settings(
              appSettings: AppSettings(
                nutrientionSettings: {},
                themeAppearance: {},
                accuracy: {},
                supportedLanguage: {},
                storageManagement: {},
              ),
              access: Access(
                purchaseHistory: {},
                socialMediaIntegration: {},
                appUpdates: {},
                subscriptionManagement: {},
                dataUsage: {},
              ),
              services: Services(
                privacyPolicy: {},
                feedback: {},
                termsOfService: {},
                appVersion: {},
              )),
          goals: Goals(
            section1: Section1(
                userGoalManagement: UserGoalManagement(
                    goalCategories: GoalCategories(range: [], selected: ''),
                    customGoals: {},
                    aiRecommendations: {}),
                foodProductAnalysis: FoodProductAnalysis(mlModel: {}),
                foodProductConclusion: FoodProductConclusion(
                    goalAlignmentReport: {}, instantAlerts: {})),
            section2: Section2(
              healthDataRecordingAndVisualization:
                  HealthDataRecordingAndVisualization(
                      healthMetricsTracking: {},
                      habitInsights: {},
                      periodicReports: {},
                      integrationWithWearables: {}),
              other: Other(
                recipeSuggestions: {},
                mealPlanning: {},
              ),
            ),
          ),
        ));
  }
}
