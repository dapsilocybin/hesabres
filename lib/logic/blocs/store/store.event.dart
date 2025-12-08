import 'package:equatable/equatable.dart';
import '../../../data/models/store.model.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();
  @override List<Object?> get props => [];
}

class LoadStores extends StoreEvent {
  final String ownerId;
  const LoadStores(this.ownerId);
  @override List<Object?> get props => [ownerId];
}

class CreateStore extends StoreEvent {
  final StoreModel store;
  const CreateStore(this.store);
  @override List<Object?> get props => [store];
}

class UpdateStore extends StoreEvent {
  final StoreModel store;
  const UpdateStore(this.store);
  @override List<Object?> get props => [store];
}

class DeleteStore extends StoreEvent {
  final String id;
  const DeleteStore(this.id);
  @override List<Object?> get props => [id];
}
