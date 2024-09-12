part of 'location_cubit.dart';

sealed class LocationState extends Equatable {
  final String? address;

  LocationState({this.address});

  @override
  List<Object?> get props => [address];
}


final class ChangeState extends LocationState {
  ChangeState({required super.address});

  @override
  List<Object?> get props => [address];
}