import 'package:equatable/equatable.dart';
import '../../../data/models/payment.model.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();
  @override List<Object?> get props => [];
}

class CreatePayment extends PaymentEvent {
  final PaymentModel payment;
  const CreatePayment(this.payment);
  @override List<Object?> get props => [payment];
}

class LoadPaymentsByStore extends PaymentEvent {
  final String storeId;
  const LoadPaymentsByStore(this.storeId);
  @override List<Object?> get props => [storeId];
}

class LoadPaymentsByOrder extends PaymentEvent {
  final String orderId;
  const LoadPaymentsByOrder(this.orderId);
  @override List<Object?> get props => [orderId];
}

class UpdatePaymentStatus extends PaymentEvent {
  final PaymentModel payment;
  const UpdatePaymentStatus(this.payment);
  @override List<Object?> get props => [payment];
}
