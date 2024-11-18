part of 'curd_tender_cubit.dart';

sealed class CurdTenderState extends Equatable {
  const CurdTenderState();

  @override
  List<Object> get props => [];
}

class CurdTenderInitial extends CurdTenderState {}

class LoadingCurdTenderState extends CurdTenderState {}

class ErrorCurdTenderState extends CurdTenderState {
  final String message;

  const ErrorCurdTenderState({required this.message});

  @override
  List<Object> get props => [message];
}
final class TenderFetchedState extends CurdTenderState {
  final List<Tender> tenders;
  const TenderFetchedState({required this.tenders});
}

class MessageCurdTenderState extends CurdTenderState {
  final String message;
  final Tender tender;

  const MessageCurdTenderState({required this.message, required this.tender});

  @override
  List<Object> get props => [tender];
}
