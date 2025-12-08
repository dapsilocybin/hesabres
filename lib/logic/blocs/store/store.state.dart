import 'package:equatable/equatable.dart';
import '../../../data/models/store.model.dart';

abstract class StoreState extends Equatable {
  const StoreState();
  @override List<Object?> get props => [];
}

class StoreInitial extends StoreState {}

class StoreLoading extends StoreState {}

class StoreLoaded extends StoreState {
  final List<StoreModel> stores;
  const StoreLoaded(this.stores);
  @override List<Object?> get props => [stores];
}

class StoreOperationSuccess extends StoreState {
  final StoreModel store;
  const StoreOperationSuccess(this.store);
  @override List<Object?> get props => [store];
}

class StoreError extends StoreState {
  final String message;
  const StoreError(this.message);
  @override List<Object?> get props => [message];
}
