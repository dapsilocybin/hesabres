import 'package:flutter_bloc/flutter_bloc.dart';
import 'subscription.event.dart';
import 'subscription.state.dart';
import '../../../data/repositories/user_subscriptions.repository.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final UserSubscriptionsRepository repository;
  SubscriptionBloc({required this.repository}) : super(SubscriptionInitial()) {
    on<LoadUserSubscription>(_onLoad);
    on<CreateUserSubscription>(_onCreate);
    on<UpdateUserSubscription>(_onUpdate);
  }

  Future<void> _onLoad(LoadUserSubscription event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final sub = await repository.getActiveSubscription(event.userId);
      if (sub == null) {
        emit(SubscriptionError('No active subscription'));
      } else {
        emit(SubscriptionLoaded(sub));
      }
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> _onCreate(CreateUserSubscription event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final created = await repository.insert(event.subscription);
      emit(SubscriptionOperationSuccess(created));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }

  Future<void> _onUpdate(UpdateUserSubscription event, Emitter<SubscriptionState> emit) async {
    emit(SubscriptionLoading());
    try {
      final updated = await repository.update(event.subscription);
      emit(SubscriptionOperationSuccess(updated));
    } catch (e) {
      emit(SubscriptionError(e.toString()));
    }
  }
}
