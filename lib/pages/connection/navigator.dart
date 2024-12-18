import 'package:flutter/material.dart';

import 'package:nutrito/network/bloc/conn_state.dart' as conn;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrito/network/bloc/conn_bloc.dart';
import 'package:nutrito/pages/connection/connectivity.dart';

class NavigatorPage extends StatefulWidget {
  Widget desireWidget;

  NavigatorPage({super.key, required this.desireWidget});

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConnBloc, conn.ConnectionState>(
      builder: (context, state) {
        if (state is conn.DesireState) {
          return widget.desireWidget;
        } else if (state is conn.ConnectivityState) {
          return ConnectivityPage();
        } else {
          return ConnectivityPage();
        }
      },
    );
  }
}
