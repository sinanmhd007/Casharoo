import 'package:chaching/Transaction/model/Transactionmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';

const TransactionDB = 'TransactionDB';

abstract class TransactionDbFunction {
  Future<void> addTransaction(Transactionmodel obj);
  Future<List<Transactionmodel>> getAllTransactions();
  Future<void> deleteTransaction(String id);
}

ValueNotifier<List<Transactionmodel>> transactionNotifier = ValueNotifier([]);

class transaction implements TransactionDbFunction {
  transaction._internal();
  static final transaction instance = transaction._internal();
  factory transaction() {
    return instance;
  }

  @override
  Future<void> addTransaction(Transactionmodel obj) async {
    final _db = await Hive.openBox<Transactionmodel>(TransactionDB);
    await _db.put(obj.id, obj);
    refreshUI();
  }

  @override
  Future<List<Transactionmodel>> getAllTransactions() async {
    final _db = await Hive.openBox<Transactionmodel>(TransactionDB);
    return _db.values.toList();
  }

  @override
  Future<void> deleteTransaction(String id) async {
    final _db = await Hive.openBox<Transactionmodel>(TransactionDB);
    await _db.delete(id);
    refreshUI();
  }

  Future<void> refreshUI() async {
    final allTransactions = await getAllTransactions();
    allTransactions.sort((a, b) => b.date.compareTo(a.date));
    transactionNotifier.value = List.from(
      allTransactions); // assign a new list
  }
}
