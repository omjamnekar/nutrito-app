import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/provider/nutrilization.dart';

class NutriOutPage extends ConsumerStatefulWidget {
  const NutriOutPage({
    super.key,
  });

  @override
  ConsumerState<NutriOutPage> createState() => _NutriOutPageState();
}

class _NutriOutPageState extends ConsumerState<NutriOutPage> {
  Widget widgettoShow = SizedBox(
    width: 90,
    height: 90,
    child: Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) {
    final nutritionalProvider =
        ref.watch(nutrilizationCrrntProvider.notifier).getState();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.value(
            nutritionalProvider.genNutrilizationResponse,
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return widgettoShow;
            } else if (snapshot.connectionState == ConnectionState.none) {
              return widgettoShow;
            } else if (snapshot.connectionState == ConnectionState.done) {
              final nutriFact = snapshot.data;

              return SingleChildScrollView(
                child: Text(
                    " ${nutriFact!.initialPromptManager?.toJson().toString() ?? ""} ${nutriFact.healthPromptManager?.toJson().toString() ?? ""} ${nutriFact.ratioPromptManager?.toJson().toString() ?? ""} ${nutriFact.conclusionPromptManger?.toJson().toString() ?? ""}"),
              );
            } else {
              return widgettoShow;
            }
          },
        ),
      ),
    );
  }
}
