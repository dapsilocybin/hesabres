import 'package:equatable/equatable.dart';
import '../../../data/models/plan.model.dart';

abstract class PlanEvent extends Equatable {
  const PlanEvent();
  @override List<Object?> get props => [];
}

class LoadPlans extends PlanEvent {}

class CreatePlan extends PlanEvent {
  final PlanModel plan;
  const CreatePlan(this.plan);
  @override List<Object?> get props => [plan];
}

class UpdatePlan extends PlanEvent {
  final PlanModel plan;
  const UpdatePlan(this.plan);
  @override List<Object?> get props => [plan];
}
