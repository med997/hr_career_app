import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'tab_nav_state.dart';

class TabNavCubit extends Cubit<TabNavState> {
  TabNavCubit() : super(TabNavChangedState(selectedTab: 0));


  Future<void> changeTab(int tabIndex) async {
    emit(TabNavChangedState(selectedTab: tabIndex));


  }
}
