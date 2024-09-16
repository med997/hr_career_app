import 'package:bloc/bloc.dart';

class ReloadBtnCubit extends Cubit<bool> {
  ReloadBtnCubit() : super(false); // Initial state is not liked

  void toggleClicked(bool clicked) {
    emit(false);
    emit(clicked);
  }// Toggle the like state
}