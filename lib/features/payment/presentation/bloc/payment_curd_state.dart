part of 'payment_curd_cubit.dart';

sealed class PaymentCurdState extends Equatable {
  const PaymentCurdState();
  @override
  List<Object> get props => [];
}

class CurdPaymentInitial extends PaymentCurdState {}

class LoadingCurdPaymentState extends PaymentCurdState {}

class ErrorCurdPaymentState extends PaymentCurdState {
  final String message;
  const ErrorCurdPaymentState({required this.message});
  @override
  List<Object> get props => [message];
}

class MessageCurdPaymentState extends PaymentCurdState {
  final String message;
  const MessageCurdPaymentState({required this.message});
  @override
  List<Object> get props => [];
}