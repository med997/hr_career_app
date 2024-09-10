part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  final String address;

  LocationState({this.address = "null"});

  @override
  List<Object?> get props => [address]; // Include address in props
}

final class LocationInitial extends LocationState {
  LocationInitial() : super();

  @override
  List<Object?> get props => []; // No address to track in initial state
}

final class ChangeState extends LocationState {
  ChangeState({required super.address});

  @override
  List<Object?> get props => [address];
}