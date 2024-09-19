part of 'company_profile_cubit.dart';

sealed class CompanyProfileState extends Equatable {
  @override
  List<Object> get props => [];
}
final class CompanyProfileInitial extends CompanyProfileState {
   CompanyProfileInitial();
}
final class CompanyLoading extends CompanyProfileState {
  CompanyLoading();
}
final class CompanyFetchedState extends CompanyProfileState {
  final Company company;
  CompanyFetchedState({required this.company});
}
final class CompanyErrorState extends CompanyProfileState{
  final String msg;
   CompanyErrorState({required this.msg});
}
