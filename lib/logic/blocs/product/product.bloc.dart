import 'package:flutter_bloc/flutter_bloc.dart';
import 'product.event.dart';
import 'product.state.dart';
import '../../../data/repositories/products.repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductsRepository repository;

  ProductBloc({required this.repository}) : super(ProductInitial()) {
    on<LoadProducts>(_onLoadProducts);
    on<CreateProduct>(_onCreateProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
  }

  Future<void> _onLoadProducts(LoadProducts event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final products = await repository.getByStore(event.storeId);
      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onCreateProduct(CreateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final created = await repository.insert(event.product);
      emit(ProductOperationSuccess(created));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(UpdateProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      final updated = await repository.update(event.product);
      emit(ProductOperationSuccess(updated));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }

  Future<void> _onDeleteProduct(DeleteProduct event, Emitter<ProductState> emit) async {
    emit(ProductLoading());
    try {
      await repository.delete(event.id);
      // after delete, you might want to reload list in UI
      emit(ProductInitial());
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
