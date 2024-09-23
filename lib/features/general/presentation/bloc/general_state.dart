part of 'general_cubit.dart';

sealed class GeneralState extends Equatable {
  const GeneralState();

  @override
  List<Object> get props => [];
}

final class GeneralInitial extends GeneralState {
  const GeneralInitial();
}

final class GeneralLoading extends GeneralState {
  const GeneralLoading();
}

final class GeneralFetchedState extends GeneralState {
  final General generals;
  const GeneralFetchedState({required this.generals});

}

final class GeneralErrorState extends GeneralState {
  final String msg;
  const GeneralErrorState({required this.msg});
}
