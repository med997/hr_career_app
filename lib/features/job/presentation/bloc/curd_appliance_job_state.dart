part of 'curd_appliance_job_cubit.dart';

sealed class CurdApplianceJobState extends Equatable{
  const CurdApplianceJobState();
  @override
  List<Object> get props => [];
}

final class CurdApplianceJobInitial extends CurdApplianceJobState {}

final class LoadingCurdApplianceJobState extends CurdApplianceJobState {}

class ErrorCurdApplianceJobState extends CurdApplianceJobState {
  final String message;
  const ErrorCurdApplianceJobState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageCurdApplianceJobState extends CurdApplianceJobState {
   final String message;
   final int applianceId;
  const MessageCurdApplianceJobState({required this.message, required this.applianceId});
  @override
  List<Object> get props => [applianceId];
}