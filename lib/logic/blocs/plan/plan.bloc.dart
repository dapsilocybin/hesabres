import 'package:flutter_bloc/flutter_bloc.dart';
import 'plan.event.dart';
import 'plan.state.dart';
import '../../../data/repositories/plans.repository.dart';

class PlanBloc extends Bloc<PlanEvent, PlanState> {
  final PlansRepository repository;
  PlanBloc({required this.repository}) : super(PlanInitial()) {
    on<LoadPlans>(_onLoadPlans);
    on<CreatePlan>(_onCreatePlan);
    on<UpdatePlan>(_onUpdatePlan);
  }

  Future<void> _onLoadPlans(LoadPlans event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final plans = await repository.getAll();
      emit(PlansLoaded(plans));
    } catch (e) {
      emit(PlanError(e.toString()));
    }
  }

  Future<void> _onCreatePlan(CreatePlan event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final created = await repository.insert(event.plan);
      emit(PlanOperationSuccess(created));
    } catch (e) {
      emit(PlanError(e.toString()));
    }
  }

  Future<void> _onUpdatePlan(UpdatePlan event, Emitter<PlanState> emit) async {
    emit(PlanLoading());
    try {
      final updated = await repository.update(event.plan);
      emit(PlanOperationSuccess(updated));
    } catch (e) {
      emit(PlanError(e.toString()));
    }
  }
}
