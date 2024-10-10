
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fleather/fleather.dart';
import 'package:hr_career_platform/features/job/domain/entities/job.dart';
import 'package:hr_career_platform/features/job/domain/usercase/update_job.dart';
import 'package:parchment_to_html/parachment_to_html.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/usercase/add_job.dart';

part 'curd_job_state.dart';

class CurdJobCubit extends Cubit<CurdJobState> {
  final AddJobUserCase addJobUserCase;
  final UpdateJob updateJobUseCase;
  CurdJobCubit({required this.addJobUserCase, required this.updateJobUseCase}) : super(CurdJobInitial());



  Future<void> updateJob(Map<String,dynamic>? value,Job jobRef) async {
    emit(LoadingCurdJobState());

    Job job = Job(
        companyId:jobRef.companyId,
        id: jobRef.id,
        jobTitle: value!['jobTitle']==null||value['jobTitle']==''?jobRef.jobTitle:value['jobTitle'],
        gender: value['gender']??jobRef.gender,
        office: value['office']??jobRef.office,
        otherApplyLinks: value['otherApplyLinks']??jobRef.otherApplyLinks,
        address: value['address']??jobRef.address,
        timeParts: value['timeParts']??jobRef.timeParts,
        city: value['city']==null||value['city']==''?jobRef.city:value['city'],
        category: value['category']??jobRef.category,
        nationalities: value['nationalities']??jobRef.nationalities,
        qualifications: value['qualifications']??jobRef.qualifications,
        jobDesc: (value['jobDesc'] as ParchmentDocument).toPlainText(),
        jobDescFormated: (value['jobDesc'] != null && value['jobDesc'] != '')
            ? (value['jobDesc'] as ParchmentDocument).toJson()
            :(value['jobDesc'] as ParchmentDocument).toJson(),
        jobReqFormated:(value['jobRequirements'] as ParchmentDocument).toJson(),
        jobRequirements: (value['jobRequirements'] as ParchmentDocument).toPlainText());


    final failureOrSuccess = await updateJobUseCase.call(job);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }
  Future<void> insertJob(Map<String,dynamic>? value,String companyId) async {
    emit(LoadingCurdJobState());
    Job job = Job(
        jobTitle: value!['jobTitle'],
        gender: value['gender'],
        office: value['office'],
        otherApplyLinks: value['otherApplyLinks'],
        address: value['address'],
        timeParts: value['timeParts'],
        city: value['city']??'',
        category: value['category']??'',
        nationalities: value['nationalities'],
        qualifications: value['qualifications'],
        status: 'draft',
        companyId:companyId,
        jobDesc: (value['jobDesc'] as ParchmentDocument).toPlainText(),
        jobDescFormated:(value['jobDesc'] as ParchmentDocument).toJson(),
        jobReqFormated:(value['jobRequirements'] as ParchmentDocument).toJson(),
        jobRequirements: (value['jobRequirements'] as ParchmentDocument).toPlainText());
    final failureOrSuccess = await addJobUserCase.call(job);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'insertDone'));
  }

  CurdJobState _eitherDoneMessageOrErrorState(
      Either<Failure, Job> either, String message) {
    return either.fold(
          (failure) => ErrorCurdJobState(
        message: _mapFailureToMessage(failure),
      ),
          (job) => MessageCurdJobState(job: job,message: message),
    );
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return SERVER_FAILURE_MESSAGE;
      case const (OfflineFailure):
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return "Unexpected Error , Please try again later .";
    }
  }
}
