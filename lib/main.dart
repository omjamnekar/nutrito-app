import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/bloc/nutri_bloc.dart';
import 'package:nutrito/network/depandancies.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:nutrito/util/theme/theme.dart';
import 'package:nutrito/view/connection/navigator.dart';
import 'package:nutrito/view/functions/nutrilization.dart';
import 'package:nutrito/view/media/sections/allpost.dart';
import 'network/firebase/firebase_options.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Supabase.initialize(
    url: dotenv.get("SUPABASEURL"),
    anonKey: dotenv.get("SUPABASEKEY"),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
  DependancyInjection.init();
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themmode = ref.watch(themeNotifierProvider);
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
      child: GetMaterialApp(
        title: "Nutrito-beta",
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode: themmode,
        debugShowCheckedModeBanner: false,
        home: NavigatorPage(),
        //  home: DemoPage(),
        // home: AlternativePage(),
        // home: GenPage(),
      ),
    );
  }
}
