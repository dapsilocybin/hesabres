import 'package:equatable/equatable.dart';
import '../../../data/models/plan.model.dart';

abstract class PlanState extends Equatable {
  const PlanState();
  @override List<Object?> get props => [];
}

class PlanInitial extends PlanState {}

class PlanLoading extends PlanState {}

class PlansLoaded extends PlanState {
  final List<PlanModel> plans;
  const PlansLoaded(this.plans);
  @override List<Object?> get props => [plans];
}

class PlanOperationSuccess extends PlanState {
  final PlanModel plan;
  const PlanOperationSuccess(this.plan);
  @override List<Object?> get props => [plan];
}

class PlanError extends PlanState {
  final String message;
  const PlanError(this.message);
  @override List<Object?> get props => [message];
}
