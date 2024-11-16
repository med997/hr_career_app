import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:fleather/fleather.dart';
import 'package:hr_career_platform/features/tender/domain/usecases/add_tender.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/strings/failures.dart';
import '../../domain/entities/tender.dart';
import '../../domain/usecases/update_tender.dart';

part 'curd_tender_state.dart';

class CurdTenderCubit extends Cubit<CurdTenderState> {
  final AddTenderUserCase addTenderUserCase;
  final UpdateTenderUserCase updateTenderUserCase;

  CurdTenderCubit({
    required this.updateTenderUserCase,
    required this.addTenderUserCase,
  }) : super(CurdTenderInitial());

  Future<void> insertTender(
      Map<String, dynamic>? value, String companyId) async {
    emit(LoadingCurdTenderState());
    Tender tender = Tender(
        tenderTitle: value!['tenderTitle'],
        otherApplyLinks:
            (value['otherApplyLinks'] as ParchmentDocument).toPlainText(),
        otherApplyLinksFormated:
            (value['otherApplyLinks'] as ParchmentDocument).toJson(),
        city: value['city'] ?? '',
        category: value['category'] ?? '',
        nationalities: value['nationalities'],
        status: 'draft',
        companyId: companyId,
        tenderDesc: (value['tenderDesc'] as ParchmentDocument).toPlainText(),
        tenderDescFormated:
            (value['tenderDesc'] as ParchmentDocument).toJson());

    final failureOrSuccess = await addTenderUserCase.call(tender);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'insertDone'));
  }

  Future<void> updateTender(
      Map<String, dynamic>? value, Tender tenderRef) async {
    emit(LoadingCurdTenderState());
    Tender tender = Tender(
        id: tenderRef.id,
        tenderTitle: value!['tenderTitle'] == null || value['tenderTitle'] == ''
            ? tenderRef.tenderTitle
            : value['tenderTitle'],
        otherApplyLinks:
            (value['otherApplyLinks'] as ParchmentDocument).toPlainText(),
        otherApplyLinksFormated:
            (value['otherApplyLinks'] != null && value['otherApplyLinks'] != '')
                ? (value['otherApplyLinks'] as ParchmentDocument).toJson()
                : (value['otherApplyLinks'] as ParchmentDocument).toJson(),
        city: value['city'] ?? tenderRef.city,
        category: value['category'] ?? tenderRef.category,
        nationalities: value['nationalities'] ?? tenderRef.nationalities,
        companyId: tenderRef.companyId,
        tenderDesc: (value['tenderDesc'] as ParchmentDocument).toPlainText(),
        tenderDescFormated:
            (value['tenderDesc'] != null && value['tenderDesc'] != '')
                ? (value['tenderDesc'] as ParchmentDocument).toJson()
                : (value['tenderDesc'] as ParchmentDocument).toJson());

    final failureOrSuccess = await updateTenderUserCase.call(tender);
    emit(_eitherDoneMessageOrErrorState(failureOrSuccess, 'updateDone'));
  }

  CurdTenderState _eitherDoneMessageOrErrorState(
      Either<Failure, Tender> either, String message) {
    return either.fold(
      (failure) => ErrorCurdTenderState(
        message: _mapFailureToMessage(failure),
      ),
      (tender) => MessageCurdTenderState(tender: tender, message: message),
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
