import 'package:equatable/equatable.dart';
import '../../../data/models/variant_type.model.dart';
import '../../../data/models/variant_value.model.dart';
import '../../../data/models/variant_product.model.dart';

abstract class VariantState extends Equatable {
  const VariantState();
  @override List<Object?> get props => [];
}

class VariantInitial extends VariantState {}

class VariantLoading extends VariantState {}

class VariantTypesLoaded extends VariantState {
  final List<VariantTypeModel> types;
  const VariantTypesLoaded(this.types);
  @override List<Object?> get props => [types];
}

class VariantValuesLoaded extends VariantState {
  final List<VariantValueModel> values;
  const VariantValuesLoaded(this.values);
  @override List<Object?> get props => [values];
}

class VariantProductsLoaded extends VariantState {
  final List<VariantProductModel> variants;
  const VariantProductsLoaded(this.variants);
  @override List<Object?> get props => [variants];
}

class VariantOperationSuccess extends VariantState {
  final VariantProductModel variant;
  const VariantOperationSuccess(this.variant);
  @override List<Object?> get props => [variant];
}

class VariantError extends VariantState {
  final String message;
  const VariantError(this.message);
  @override List<Object?> get props => [message];
}
