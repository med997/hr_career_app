part of 'curd_job_cubit.dart';

sealed class CurdJobState extends Equatable {
  const CurdJobState();
  @override
  List<Object> get props => [];
}

class CurdJobInitial extends CurdJobState {}

class LoadingCurdJobState extends CurdJobState {}

class ErrorCurdJobState extends CurdJobState {
  final String message;
  const ErrorCurdJobState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageCurdJobState extends CurdJobState {
  final String message;
  final Job job;
  const MessageCurdJobState({required this.message, required this.job});
  @override
  List<Object> get props => [job];
}