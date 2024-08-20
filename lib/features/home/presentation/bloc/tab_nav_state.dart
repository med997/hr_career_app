part of 'tab_nav_cubit.dart';

@immutable
sealed class TabNavState extends Equatable {
  final  int selectedTab;
  const TabNavState({required this.selectedTab});
  @override
  List<Object> get props => [selectedTab];
}
class TabNavChangedState extends TabNavState{
  const TabNavChangedState({required super.selectedTab});

}

