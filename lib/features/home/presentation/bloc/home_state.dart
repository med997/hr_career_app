part of 'home_cubit.dart';

sealed class HomeState extends Equatable {

  const HomeState();



  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}
final class HomeLoading extends HomeState {
  const HomeLoading();
}
final class HomeFetchedState extends HomeState {
  final Home homes;
  const HomeFetchedState({required this.homes});
}

final class HomeErrorState extends HomeState{
  final String msg;
  const HomeErrorState({required this.msg});
}

