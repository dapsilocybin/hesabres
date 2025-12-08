import 'package:equatable/equatable.dart';
import '../../../data/models/user_subscription.model.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();
  @override List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoaded extends SubscriptionState {
  final UserSubscriptionModel subscription;
  const SubscriptionLoaded(this.subscription);
  @override List<Object?> get props => [subscription];
}

class SubscriptionOperationSuccess extends SubscriptionState {
  final UserSubscriptionModel subscription;
  const SubscriptionOperationSuccess(this.subscription);
  @override List<Object?> get props => [subscription];
}

class SubscriptionError extends SubscriptionState {
  final String message;
  const SubscriptionError(this.message);
  @override List<Object?> get props => [message];
}
