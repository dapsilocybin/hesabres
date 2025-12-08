import 'package:equatable/equatable.dart';
import '../../../data/models/order.model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();
  @override List<Object?> get props => [];
}

class CreateOrder extends OrderEvent {
  final OrderModel order;
  const CreateOrder(this.order);
  @override List<Object?> get props => [order];
}

class LoadOrdersByStore extends OrderEvent {
  final String storeId;
  const LoadOrdersByStore(this.storeId);
  @override List<Object?> get props => [storeId];
}

class LoadOrdersByBuyer extends OrderEvent {
  final String buyerId;
  const LoadOrdersByBuyer(this.buyerId);
  @override List<Object?> get props => [buyerId];
}

class UpdateOrderStatus extends OrderEvent {
  final OrderModel order;
  const UpdateOrderStatus(this.order);
  @override List<Object?> get props => [order];
}
