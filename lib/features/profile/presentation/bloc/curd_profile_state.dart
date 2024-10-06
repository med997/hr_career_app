part of 'curd_profile_cubit.dart';

sealed class CurdProfileState extends Equatable {
  const CurdProfileState();
  @override
  List<Object> get props => [];
}

final class CurdProfileInitial extends CurdProfileState {
 
} 

class LoadingCurdProfileState extends CurdProfileState {}

class ErrorCurdProfileState extends CurdProfileState {
  final String message;
  const ErrorCurdProfileState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageCurdProfileState extends CurdProfileState {
  final String message;
  const MessageCurdProfileState({required this.message});
  @override
  List<Object> get props => [message];
}
