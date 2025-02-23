import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/network/bloc/conn_state.dart';
import 'package:nutrito/view/main_page.dart';
import 'package:nutrito/view/dist/onboarding.dart';
import 'package:nutrito/view/dist/splash_Page.dart';
import 'package:nutrito/view/dist/welcome.dart';

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
        Widget page;
        if (state is HomeState) {
          page = const MainPage();
        } else if (state is SplashState) {
          page = SplashPage(
            widget: const OnboardingPage(),
          );
        } else if (state is BoardingState) {
          page = const WelcomePage();
        } else {
          page = SplashPage(
            widget: const WelcomePage(),
          );
        }

        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: page,
        );
      },
    );
  }
}
