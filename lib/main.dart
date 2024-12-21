import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/depandancies.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:nutrito/pages/connection/navigator.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  DependancyInjection.init();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BlocProvider(
      create: (context) => ConnBloc()..appStart(),
      child: ProviderScope(
        child: GetMaterialApp(
          title: 'Nutrito-beta',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: const NavigatorPage(),
        ),
      ),
    );
  }
}
