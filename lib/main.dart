import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/bloc/nutri_bloc.dart';
import 'package:nutrito/network/depandancies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrito/view/connection/navigator.dart';
import 'package:nutrito/view/functions/nutrilization.dart';
import 'package:nutrito/util/theme/color.dart';
import 'network/firebase/firebase_options.dart';
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
    return MultiBlocProvider(
      providers: [
        BlocProvider<NutriBloc>(
          create: (context) => NutriBloc(),
          child: NutriStateNavigate(),
        ),
        BlocProvider<ConnBloc>(
          create: (context) => ConnBloc()..appStart(),
        ),
      ],
      child: ProviderScope(
        child: GetMaterialApp(
          title: "Nutrito-beta",
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: ColorManager.bluePrimary),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          home: NavigatorPage(),
          // home: AlternativePage(),
          // home: GenPage(),
        ),
      ),
    );
  }
}
