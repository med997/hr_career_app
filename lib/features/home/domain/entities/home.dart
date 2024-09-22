import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

class Home extends Equatable{

  final List<Job> recentJobs;
  final List<Job>?featuredJobs;

  const Home({
    required this.recentJobs,
     this.featuredJobs,
  });
  @override
  List<Object?> get props => [];


}