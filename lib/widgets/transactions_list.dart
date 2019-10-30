import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function _deleteTransaction;

  TransactionList(this._userTransactions, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: _userTransactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                      child: Text(
                        'No transactions added yet!',
                        style: Theme.of(context).textTheme.title,
                      ),
                    ),
                    Container(
                        height: constraints.maxHeight * .7,
                        child: Image.asset('assets/images/waiting.png',
                            fit: BoxFit.cover)),
                  ],
                );
              },
            )
          : ListView(
              children: _userTransactions
                  .map((tx) => TransactionItem(
                        key: ValueKey(tx.id),
                        userTransaction: tx,
                        deleteTransaction: _deleteTransaction,
                      ))
                  .toList(),
            ),
    );
  }
}
