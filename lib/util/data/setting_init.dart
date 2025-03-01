import 'package:nutrito/data/model/sections/settings.dart';

Profile profileEmptypublic = Profile(
    section_1: Section_1(
        avatar: "",
        username: "",
        email: "",
        diataryIntake: DiataryIntake(numb: 0, type: ""),
        healthScore: HealthScore(numb: 0, type: ""),
        nutrientDeficiencies: NutrientDeficiencies(state: ""),
        weight: Weight(numb: 0, type: ""),
        weightLoss: Weight(numb: 0, type: ""),
        nutriScore: NutriScore(numb: 0, grade: "", type: ""),
        groups: [],
        profileAccess: ProfileAccess(options: [], access: "")));
