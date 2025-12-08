import 'package:equatable/equatable.dart';
import '../../../data/models/product.model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
  @override List<Object?> get props => [];
}

class LoadProducts extends ProductEvent {
  final String storeId;
  const LoadProducts(this.storeId);
  @override List<Object?> get props => [storeId];
}

class CreateProduct extends ProductEvent {
  final ProductModel product;
  const CreateProduct(this.product);
  @override List<Object?> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final ProductModel product;
  const UpdateProduct(this.product);
  @override List<Object?> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final String id;
  const DeleteProduct(this.id);
  @override List<Object?> get props => [id];
}
