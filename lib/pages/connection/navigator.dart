import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/bloc/conn_state.dart';
import 'package:nutrito/pages/home/home.dart';
import 'package:nutrito/pages/onboarding.dart';
import 'package:nutrito/pages/splash_Page.dart';
import 'package:nutrito/pages/welcome.dart';

class NavigatorPage extends StatefulWidget {
  const NavigatorPage({super.key});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnBloc, ConnState>(
      builder: (context, state) {
        if (state is HomeState) {
          return HomePage();
        } else if (state is SplashState) {
          return SplashPage(
            widget: OnboardingPage(),
          );
        } else if (state is BoardingState) {
          return WelcomePage();
        } else {
          return SplashPage(
            widget: WelcomePage(),
          );
        }
      },
    );
  }
}
