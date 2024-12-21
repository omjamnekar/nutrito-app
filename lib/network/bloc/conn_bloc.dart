import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrito/data/storage/user_Data.dart';
import 'package:nutrito/network/bloc/conn_state.dart';
import 'package:nutrito/pages/home/home.dart';

class ConnBloc extends Cubit<ConnState> {
  ConnBloc() : super(SplashState());

  Future<void> appStart() async {
    UserStore userStore = UserStore();
    final validState = await userStore.loadData();

    await Future.delayed(Duration(seconds: 2));
    if (validState.email != null && validState.email!.isNotEmpty) {
      emit(HomeState());
    } else {
      emit(BoardingState());
    }
  }

  Future<void> changeToBoarding() async {
    emit(BoardingState());
  }
}
