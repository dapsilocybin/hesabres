import 'package:equatable/equatable.dart';
import '../../../data/models/variant_type.model.dart';
import '../../../data/models/variant_value.model.dart';
import '../../../data/models/variant_product.model.dart';

abstract class VariantEvent extends Equatable {
  const VariantEvent();
  @override List<Object?> get props => [];
}

// Variant types
class LoadVariantTypes extends VariantEvent {
  final String storeId;
  const LoadVariantTypes(this.storeId);
  @override List<Object?> get props => [storeId];
}

class CreateVariantType extends VariantEvent {
  final VariantTypeModel type;
  const CreateVariantType(this.type);
  @override List<Object?> get props => [type];
}

// Variant values
class LoadVariantValues extends VariantEvent {
  final String typeId;
  const LoadVariantValues(this.typeId);
  @override List<Object?> get props => [typeId];
}

class CreateVariantValue extends VariantEvent {
  final VariantValueModel value;
  const CreateVariantValue(this.value);
  @override List<Object?> get props => [value];
}

// Variant products (combinations)
class LoadVariantProducts extends VariantEvent {
  final String productId;
  const LoadVariantProducts(this.productId);
  @override List<Object?> get props => [productId];
}

class CreateVariantProduct extends VariantEvent {
  final VariantProductModel variant;
  const CreateVariantProduct(this.variant);
  @override List<Object?> get props => [variant];
}

class UpdateVariantProduct extends VariantEvent {
  final VariantProductModel variant;
  const UpdateVariantProduct(this.variant);
  @override List<Object?> get props => [variant];
}
