part of 'package_cubit.dart';

sealed class PackageState extends Equatable {
  const PackageState();
  @override
  List<Object> get props => [];
}

final class PackageInitial extends PackageState {

}
final class PackageLoadingState extends PackageState {}
final class PackageFetchedState extends PackageState {
  final List<Package> packages;
  const PackageFetchedState({required this.packages});
}

final class PackageErrorState extends PackageState{
  final String msg;
  const PackageErrorState({required this.msg});
}
