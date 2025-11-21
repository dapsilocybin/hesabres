import 'package:flutter_bloc/flutter_bloc.dart';
import 'order.event.dart';
import 'order.state.dart';
import '../../../data/repositories/orders.repository.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final OrdersRepository repository;
  OrderBloc({required this.repository}) : super(OrderInitial()) {
    on<CreateOrder>(_onCreateOrder);
    on<LoadOrdersByStore>(_onLoadOrdersByStore);
    on<LoadOrdersByBuyer>(_onLoadOrdersByBuyer);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
  }

  Future<void> _onCreateOrder(CreateOrder event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final created = await repository.insert(event.order);
      emit(OrderOperationSuccess(created));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onLoadOrdersByStore(LoadOrdersByStore event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final orders = await repository.getOrdersByStoreId(event.storeId);
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onLoadOrdersByBuyer(LoadOrdersByBuyer event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final orders = await repository.getOrdersByBuyerId(event.buyerId);
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> _onUpdateOrderStatus(UpdateOrderStatus event, Emitter<OrderState> emit) async {
    emit(OrderLoading());
    try {
      final updated = await repository.update(event.order);
      emit(OrderOperationSuccess(updated));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
