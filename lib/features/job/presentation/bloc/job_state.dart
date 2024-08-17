part of 'job_cubit.dart';

sealed class JobState extends Equatable {
  const JobState();
  @override
  List<Object> get props => [];
}

final class JobInitial extends JobState {

}
final class JobLoadingState extends JobState {}
final class JobFetchedState extends JobState {
  final List<Job> jobs;
  const JobFetchedState({required this.jobs});
}

final class JobErrorState extends JobState{
  final String msg;
  const JobErrorState({required this.msg});
}
