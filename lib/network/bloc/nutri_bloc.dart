import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrito/network/bloc/nutri_state.dart';

class NutriBloc extends Cubit<NutriState> {
  NutriBloc() : super(NutriStart());

  void onClickNutri() {
    emit(GenLoadingState());
  }

  void onDataReceive() {
    emit(GenOutput());
  }
}
