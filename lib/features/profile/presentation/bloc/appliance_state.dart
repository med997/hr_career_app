part of 'appliance_cubit.dart';

sealed class ApplianceState extends Equatable {
  const ApplianceState();
  @override
  List<Object> get props => [];
}
final class ApplianceInitial extends ApplianceState {
 ApplianceInitial();
}
final class ApplianceLoading extends ApplianceState {
  ApplianceLoading();
}
final class ApplianceFetchedState extends ApplianceState {
  final List<Profile> profile;
  ApplianceFetchedState({required this.profile});
}
final class ApplianceErrorState extends ApplianceState{
  final String msg;
  ApplianceErrorState({required this.msg});
}