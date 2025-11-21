import 'package:equatable/equatable.dart';
import '../../../data/models/wallet_transaction.model.dart';
import '../../../data/models/withdraw_request.model.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();
  @override List<Object?> get props => [];
}

class LoadWallet extends WalletEvent {
  final String userId;
  const LoadWallet(this.userId);
  @override List<Object?> get props => [userId];
}

class AddTransaction extends WalletEvent {
  final WalletTransactionModel tx;
  const AddTransaction(this.tx);
  @override List<Object?> get props => [tx];
}

class CreateWithdrawRequest extends WalletEvent {
  final WithdrawRequestModel request;
  const CreateWithdrawRequest(this.request);
  @override List<Object?> get props => [request];
}
