import 'package:flutter_bloc/flutter_bloc.dart';
import 'variant.event.dart';
import 'variant.state.dart';
import '../../../data/repositories/variant_types.repository.dart';
import '../../../data/repositories/variant_values.repository.dart';
import '../../../data/repositories/variant_products.repository.dart';

class VariantBloc extends Bloc<VariantEvent, VariantState> {
  final VariantTypesRepository typesRepo;
  final VariantValuesRepository valuesRepo;
  final VariantProductsRepository productsRepo;

  VariantBloc({
    required this.typesRepo,
    required this.valuesRepo,
    required this.productsRepo,
  }) : super(VariantInitial()) {
    on<LoadVariantTypes>(_onLoadTypes);
    on<CreateVariantType>(_onCreateType);
    on<LoadVariantValues>(_onLoadValues);
    on<CreateVariantValue>(_onCreateValue);
    on<LoadVariantProducts>(_onLoadVariantProducts);
    on<CreateVariantProduct>(_onCreateVariantProduct);
    on<UpdateVariantProduct>(_onUpdateVariantProduct);
  }

  Future<void> _onLoadTypes(LoadVariantTypes event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final types = await typesRepo.getByStore(event.storeId);
      emit(VariantTypesLoaded(types));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _onCreateType(CreateVariantType event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final created = await typesRepo.insert(event.type);
      final types = await typesRepo.getByStore(created.storeId);
      emit(VariantTypesLoaded(types));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _onLoadValues(LoadVariantValues event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final values = await valuesRepo.getByType(event.typeId);
      emit(VariantValuesLoaded(values));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _onCreateValue(CreateVariantValue event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final created = await valuesRepo.insert(event.value);
      final values = await valuesRepo.getByType(created.variantTypeId);
      emit(VariantValuesLoaded(values));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _onLoadVariantProducts(LoadVariantProducts event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final variants = await productsRepo.getByProduct(event.productId);
      emit(VariantProductsLoaded(variants));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _onCreateVariantProduct(CreateVariantProduct event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final created = await productsRepo.insert(event.variant);
      emit(VariantOperationSuccess(created));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }

  Future<void> _onUpdateVariantProduct(UpdateVariantProduct event, Emitter<VariantState> emit) async {
    emit(VariantLoading());
    try {
      final updated = await productsRepo.update(event.variant);
      emit(VariantOperationSuccess(updated));
    } catch (e) {
      emit(VariantError(e.toString()));
    }
  }
}
