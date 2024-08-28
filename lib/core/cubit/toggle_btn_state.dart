part of 'toggle_btn_cubit.dart';

sealed class ToggleBtnState extends Equatable {
  final int selectedTab;

  ToggleBtnState({required this.selectedTab});

  @override
  List<Object> get props => [selectedTab];

}


class ToggleBtnChangedState extends ToggleBtnState{
  ToggleBtnChangedState({required super.selectedTab});
}

