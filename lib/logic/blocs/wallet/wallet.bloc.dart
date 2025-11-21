import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hesabres/data/models/wallet_transaction.model.dart';
import '../../../data/repositories/wallet.repository.dart';
import 'wallet.event.dart';
import 'wallet.state.dart';
import '../../../data/repositories/wallet_transactions.repository.dart';
import '../../../data/repositories/withdraw_requests.repository.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletsRepository walletsRepo;
  final WalletTransactionsRepository txRepo;
  final WithdrawRequestsRepository withdrawRepo;

  WalletBloc({
    required this.walletsRepo,
    required this.txRepo,
    required this.withdrawRepo,
  }) : super(WalletInitial()) {
    on<LoadWallet>(_onLoadWallet);
    on<AddTransaction>(_onAddTransaction);
    on<CreateWithdrawRequest>(_onCreateWithdrawRequest);
  }

  Future<void> _onLoadWallet(LoadWallet event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    try {
      final wallet = await walletsRepo.getByUser(event.userId);
      final txs = wallet == null ? <dynamic>[] : await txRepo.getByWallet(wallet.id);
      emit(WalletLoaded(wallet!, txs as List<WalletTransactionModel>));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onAddTransaction(AddTransaction event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    try {
      final created = await txRepo.insert(event.tx);
      // reload wallet
      final wallet = await walletsRepo.getByUser(event.tx.walletId);
      final txs = await txRepo.getByWallet(event.tx.walletId);
      emit(WalletLoaded(wallet!, txs));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onCreateWithdrawRequest(CreateWithdrawRequest event, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    try {
      final req = await withdrawRepo.insert(event.request);
      final wallet = await walletsRepo.getByUser(event.request.walletId!);
      final txs = await txRepo.getByWallet(event.request.walletId!);
      emit(WalletLoaded(wallet!, txs));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }
}
