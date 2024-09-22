part of 'curd_company_cubit.dart';

sealed class CurdCompanyState extends Equatable {
  const CurdCompanyState();
  @override
  List<Object> get props => [];
}

class CurdCompanyInitial extends CurdCompanyState {}

class LoadingCurdCompanyState extends CurdCompanyState {}

class ErrorCurdCompanyState extends CurdCompanyState {
  final String message;
  ErrorCurdCompanyState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageCurdCompanyState extends CurdCompanyState {
  final String message;
  MessageCurdCompanyState({required this.message});
  @override
  List<Object> get props => [message];
}
