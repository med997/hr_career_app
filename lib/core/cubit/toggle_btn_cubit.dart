import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_btn_state.dart';

class ToggleBtnCubit extends Cubit<ToggleBtnState> {
  ToggleBtnCubit() : super(ToggleBtnChangedState(selectedTab: 0));


  Future<void> changeTab(int tabIndex) async {
    emit(ToggleBtnChangedState(selectedTab: tabIndex));


  }
}
