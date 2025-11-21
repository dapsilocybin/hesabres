import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment.event.dart';
import 'payment.state.dart';
import '../../../data/repositories/payments.repository.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final PaymentsRepository repository;

  PaymentBloc({required this.repository}) : super(PaymentInitial()) {
    on<CreatePayment>(_onCreatePayment);
    on<LoadPaymentsByStore>(_onLoadPaymentsByStore);
    // on<LoadPaymentsByOrder>(_onLoadPaymentsByOrder);
    on<UpdatePaymentStatus>(_onUpdatePaymentStatus);
  }

  Future<void> _onCreatePayment(CreatePayment event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final created = await repository.insert(event.payment);
      emit(PaymentOperationSuccess(created));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  Future<void> _onLoadPaymentsByStore(LoadPaymentsByStore event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final payments = await repository.getPaymentsByStoreId(event.storeId);
      emit(PaymentsLoaded(payments));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }

  // Future<void> _onLoadPaymentsByOrder(LoadPaymentsByOrder event, Emitter<PaymentState> emit) async {
  //   emit(PaymentLoading());
  //   try {
  //     final payments = await repository.getByOrderId(event.orderId);
  //     emit(PaymentsLoaded(payments));
  //   } catch (e) {
  //     emit(PaymentError(e.toString()));
  //   }
  // }

  Future<void> _onUpdatePaymentStatus(UpdatePaymentStatus event, Emitter<PaymentState> emit) async {
    emit(PaymentLoading());
    try {
      final updated = await repository.update(event.payment);
      emit(PaymentOperationSuccess(updated));
    } catch (e) {
      emit(PaymentError(e.toString()));
    }
  }
}
