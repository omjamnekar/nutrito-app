import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:nutrito/data/model/gen/com.dart';
import 'package:nutrito/data/model/gen/compare/compare.dart';
import 'package:nutrito/data/model/gen/conclusion_pr.dart';
import 'package:nutrito/data/model/gen/health_pr.dart';
import 'package:nutrito/data/model/gen/initial_pr.dart';
import 'package:nutrito/data/model/gen/nutri_com_state.dart';
import 'package:nutrito/data/model/gen/ratio_pr.dart';
import 'package:nutrito/data/repositories/genai.dart';
import 'package:nutrito/data/storage/nutri.dart';
import 'package:nutrito/data/storage/user_Data.dart';
import 'package:nutrito/network/bloc/nutri_bloc.dart';
import 'package:nutrito/network/provider/compare.dart';
import 'package:nutrito/network/provider/nutrilization.dart';
import 'package:nutrito/view/functions/display/com_out.dart';
import 'package:nutrito/view/functions/display/loading.dart';
import 'package:nutrito/view/functions/display/nutri_out.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class GenController extends GetxController {
  Rx<GenNutrilizationResponse> obxDataManager = GenNutrilizationResponse(
          conclusionPromptManger: null,
          healthPromptManager: null,
          initialPromptManager: null,
          ratioPromptManager: null)
      .obs;

  Future<void> nutrilizationCompact(File file, BuildContext context,
      WidgetRef ref, Map<String, bool> optionData) async {
    GenaiCall gencall = GenaiCall(file: file, context: context);
    final nutriBloc = BlocProvider.of<NutriBloc>(context);
    if (file.path.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("image is not selected"),
        ),
      );
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenLoading(),
          ));

      List<Object?> results;
      try {
        results = await Future.wait([
          gencall.initialPrompt().catchError((e) {
            print("Error in initialPrompt: $e");
            return null;
          }),
          gencall.healthPrompt().catchError((e) {
            print("Error in healthPrompt: $e");
            return null;
          }),
          gencall.ratioPrompt().catchError((e) {
            print("Error in ratioPrompt: $e");
            return null;
          }),
          gencall.conclusionPrompt().catchError((e) {
            print("Error in conclusionPrompt: $e");
            return null;
          }),
        ]);
      } catch (e, stackTrace) {
        print("Error in Future.wait: $e");
        print(stackTrace);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("An error occurred while processing prompts.")),
        );
        return;
      }

      InitialPromptManager? initialPromptManager = results
              .whereType<InitialPromptManager>()
              .cast<InitialPromptManager>()
              .isNotEmpty
          ? results
              .whereType<InitialPromptManager>()
              .cast<InitialPromptManager>()
              .first
          : null;

      HealthPromptManager? healthPromptManager = results
              .whereType<HealthPromptManager>()
              .cast<HealthPromptManager>()
              .isNotEmpty
          ? results
              .whereType<HealthPromptManager>()
              .cast<HealthPromptManager>()
              .first
          : null;

      RatioPromptManager? ratioPromptManager = results
              .whereType<RatioPromptManager>()
              .cast<RatioPromptManager>()
              .isNotEmpty
          ? results
              .whereType<RatioPromptManager>()
              .cast<RatioPromptManager>()
              .first
          : null;

      ConclusionPromptManger? conclusionPromptManger = results
              .whereType<ConclusionPromptManger>()
              .cast<ConclusionPromptManger>()
              .isNotEmpty
          ? results
              .whereType<ConclusionPromptManger>()
              .cast<ConclusionPromptManger>()
              .first
          : null;

      if (initialPromptManager == null ||
          healthPromptManager == null ||
          ratioPromptManager == null ||
          conclusionPromptManger == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to retrieve all prompt data.")),
        );
        return;
      }

      obxDataManager.value = GenNutrilizationResponse(
        initialPromptManager: initialPromptManager,
        healthPromptManager: healthPromptManager,
        ratioPromptManager: ratioPromptManager,
        conclusionPromptManger: conclusionPromptManger,
      );

// state notifier
      await ref
          .read(nutrilizationCrrntProvider.notifier)
          .setData(obxDataManager.value, file);

// create Firestore instance
      final userData = await UserStore().loadData();
      final firestore = FirebaseFirestore.instance;
      final userDoc = firestore.collection("foodproducts").doc(userData.id);

      await userDoc.set(
        {
          "email": userData.email ?? "",
          "nutrilication_collection": FieldValue.arrayUnion([
            {
              "id": Uuid().v4(),
              "initialPromptManager": initialPromptManager.toJson(),
              "healthPromptManager": healthPromptManager.toJson(),
              "ratioPromptManager": ratioPromptManager.toJson(),
              "conclusionPromptManger": conclusionPromptManger.toJson(),
              "timestamp": DateTime.now().toIso8601String(),
            }
          ]),
        },
        SetOptions(merge: true),
      );
      navigate(context, file, optionData);

      NutriPreference nutriPreference = NutriPreference();
      await nutriPreference.nutristore(NutriComState(
          genNutrilizationResponse: obxDataManager.value,
          fileImage: file,
          timestamp: Timestamp.now()));

      final sd = await nutriPreference.getNutriData();
      print(sd.first.id);
    }
  }

  Future<void> nutriToOutput(
      GenNutrilizationResponse response, BuildContext context) async {
    print("nutriOutput is getting start");
    if (response.initialPromptManager == null ||
        response.healthPromptManager == null ||
        response.ratioPromptManager == null ||
        response.conclusionPromptManger == null) {
      if (context.mounted) {
        print("Context is mounted. Cannot show SnackBar.");
        return;
      }
      print("Context is not mounted. Cannot show SnackBar.");

      return;
    } else {
      print("come to output page");
      BlocProvider.of<NutriBloc>(context).onDataReceive();
    }
  }

  void navigate(
      BuildContext context, File image, Map<String, bool> optionData) {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NutriOutPage(
            options: optionData,
          ),
        ));
  }

  Future<void> compareCompact(
      File file, File file2, WidgetRef ref, BuildContext context) async {
    GenaiCall genaiCall = GenaiCall(file: file, context: context);
    genaiCall.setFile2 = file2;

    if (file.path.isNotEmpty && file2.path.isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => GenLoading(),
          ));

      final result = await genaiCall.compareProduct();
      result?.file1 = file;
      result?.file2 = file2;

      if (result != null && result.compareProducts != null) {
        //  print(result.compareProducts?.toJson().toString() ?? "");
        CompareManager response = result as CompareManager? ??
            CompareManager(compareProducts: null, file1: null, file2: null);

        ref
            .watch(compareCurrntProvider.notifier)
            .setData(response, file, file2);

        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ComOutPage(),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to retrieve compare data.")),
        );
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("images not selected")));
    }
  }
}
