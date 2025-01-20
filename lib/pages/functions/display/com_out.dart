import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/provider/compare.dart';

class ComOutPage extends ConsumerStatefulWidget {
  const ComOutPage({
    super.key,
  });

  @override
  ConsumerState<ComOutPage> createState() => _NutriOutPageState();
}

class _NutriOutPageState extends ConsumerState<ComOutPage> {
  Widget widgettoShow = SizedBox(
    width: 90,
    height: 90,
    child: Center(child: CircularProgressIndicator()),
  );

  @override
  Widget build(BuildContext context) {
    final comparedProvider =
        ref.watch(compareCurrntProvider.notifier).getState();

    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Future.value(
            comparedProvider.compareManager,
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
                    " ${nutriFact!.compareProducts?.toJson().toString() ?? ""}"),
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
