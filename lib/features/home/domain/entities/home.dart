import 'package:equatable/equatable.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';

import '../../../tender/domain/entities/tender.dart';

class Home extends Equatable{

  final List<Job>? recentJobs;
  final List<Tender>? recentTender;
  final List<Job>? featuredJobs;
  final List<Tender>? featuredTender;

  const Home({
   this.recentJobs =const[],
   this.recentTender  =const[],
     this.featuredJobs =const[],
     this.featuredTender =const[],
  });
  @override
  List<Object?> get props => [];


}