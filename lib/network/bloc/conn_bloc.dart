import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nutrito/network/bloc/conn_state.dart' as conn;
import 'package:nutrito/network/bloc/conn_state.dart';
import 'package:nutrito/network/provider/connectivity.dart';

class ConnBloc extends Cubit<conn.ConnectionState> {
  ConnBloc() : super(DesireState());

  Future<void> isConAvailable(WidgetRef ref, BuildContext context) async {
    final checkConection =
        await ref.read(connectivityStateProvider.notifier).checkCurrentState();

    if (checkConection.currentState == false) {
      emit(conn.ConnectivityState());

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(checkConection.connection ?? "No connection"),
        ),
      );
    } else {}
  }
}
