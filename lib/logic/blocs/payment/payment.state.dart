import 'package:equatable/equatable.dart';
import '../../../data/models/payment.model.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();
  @override List<Object?> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentsLoaded extends PaymentState {
  final List<PaymentModel> payments;
  const PaymentsLoaded(this.payments);
  @override List<Object?> get props => [payments];
}

class PaymentOperationSuccess extends PaymentState {
  final PaymentModel payment;
  const PaymentOperationSuccess(this.payment);
  @override List<Object?> get props => [payment];
}

class PaymentError extends PaymentState {
  final String message;
  const PaymentError(this.message);
  @override List<Object?> get props => [message];
}
