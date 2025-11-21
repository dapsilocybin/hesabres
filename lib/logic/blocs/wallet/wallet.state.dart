import 'package:equatable/equatable.dart';
import '../../../data/models/wallet.model.dart';
import '../../../data/models/wallet_transaction.model.dart';

abstract class WalletState extends Equatable {
  const WalletState();
  @override List<Object?> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final WalletModel wallet;
  final List<WalletTransactionModel> transactions;
  const WalletLoaded(this.wallet, this.transactions);
  @override List<Object?> get props => [wallet, transactions];
}

class WalletOperationSuccess extends WalletState {
  final WalletModel wallet;
  const WalletOperationSuccess(this.wallet);
  @override List<Object?> get props => [wallet];
}

class WalletError extends WalletState {
  final String message;
  const WalletError(this.message);
  @override List<Object?> get props => [message];
}
