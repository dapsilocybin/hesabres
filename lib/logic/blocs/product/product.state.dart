import 'package:equatable/equatable.dart';
import '../../../data/models/product.model.dart';

abstract class ProductState extends Equatable {
  const ProductState();
  @override List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductLoaded(this.products);
  @override List<Object?> get props => [products];
}

class ProductOperationSuccess extends ProductState {
  final ProductModel product;
  const ProductOperationSuccess(this.product);
  @override List<Object?> get props => [product];
}

class ProductError extends ProductState {
  final String message;
  const ProductError(this.message);
  @override List<Object?> get props => [message];
}
