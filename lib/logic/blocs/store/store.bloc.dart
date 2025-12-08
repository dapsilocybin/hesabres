import 'package:flutter_bloc/flutter_bloc.dart';
import 'store.event.dart';
import 'store.state.dart';
import '../../../data/repositories/stores.repository.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final StoresRepository repository;
  StoreBloc({required this.repository}) : super(StoreInitial()) {
    on<LoadStores>(_onLoadStores);
    on<CreateStore>(_onCreateStore);
    on<UpdateStore>(_onUpdateStore);
    on<DeleteStore>(_onDeleteStore);
  }

  Future<void> _onLoadStores(LoadStores event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final stores = await repository.getByOwner(event.ownerId);
      emit(StoreLoaded(stores));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<void> _onCreateStore(CreateStore event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final created = await repository.insert(event.store);
      emit(StoreOperationSuccess(created));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<void> _onUpdateStore(UpdateStore event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      final updated = await repository.update(event.store);
      emit(StoreOperationSuccess(updated));
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }

  Future<void> _onDeleteStore(DeleteStore event, Emitter<StoreState> emit) async {
    emit(StoreLoading());
    try {
      await repository.delete(event.id);
      emit(StoreInitial());
    } catch (e) {
      emit(StoreError(e.toString()));
    }
  }
}
