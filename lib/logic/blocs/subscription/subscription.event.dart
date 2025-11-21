import 'package:equatable/equatable.dart';
import '../../../data/models/user_subscription.model.dart';

abstract class SubscriptionEvent extends Equatable {
  const SubscriptionEvent();
  @override List<Object?> get props => [];
}

class LoadUserSubscription extends SubscriptionEvent {
  final String userId;
  const LoadUserSubscription(this.userId);
  @override List<Object?> get props => [userId];
}

class CreateUserSubscription extends SubscriptionEvent {
  final UserSubscriptionModel subscription;
  const CreateUserSubscription(this.subscription);
  @override List<Object?> get props => [subscription];
}

class UpdateUserSubscription extends SubscriptionEvent {
  final UserSubscriptionModel subscription;
  const UpdateUserSubscription(this.subscription);
  @override List<Object?> get props => [subscription];
}
