import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/depandancies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrito/pages/connection/navigator.dart';
import 'package:nutrito/util/theme/color.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
  DependancyInjection.init();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider<ConnBloc>(
      create: (context) {
        return ConnBloc()..appStart();
      },
      child: ProviderScope(
        child: GetMaterialApp(
          title: 'Nutrito-beta',
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorManager.bluePrimary),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const NavigatorPage(),
        ),
      ),
    );
  }
}
