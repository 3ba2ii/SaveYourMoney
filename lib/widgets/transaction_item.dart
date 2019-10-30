import 'package:flutter/material.dart';

import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    Key key,
    @required Transaction userTransaction,
    @required Function deleteTransaction,
  })  : _userTransaction = userTransaction,
        _deleteTransaction = deleteTransaction,
        super(key: key);

  final Transaction _userTransaction;
  final Function _deleteTransaction;

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const List<Color> availableColors = [
      Colors.green,
      Colors.redAccent,
      Colors.black,
      Colors.deepPurple,
    ];

    if(widget._userTransaction.price>50 && widget._userTransaction.price<100) _bgColor=availableColors[3];
    else if (widget._userTransaction.price>=100 && widget._userTransaction.price<200)_bgColor=availableColors[2];
    else if (widget._userTransaction.price>=200 )_bgColor=availableColors[1];
    else _bgColor= availableColors[0];
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 2,
      ),
      child: ListTile(
        leading: CircleAvatar( 
          backgroundColor: _bgColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: FittedBox(
              child: Text(
                '\$${widget._userTransaction.price}',
              ),
            ),
          ),
        ),
        title: Text(
          '${widget._userTransaction.title}',
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(widget._userTransaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 440
            ? FlatButton.icon(
                label: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 13),
                ),
                icon: Icon(
                  Icons.clear,
                  color: Colors.redAccent[700],
                  size: 30,
                ),
                textColor: Colors.redAccent[700],
                onPressed: () =>
                    widget._deleteTransaction(widget._userTransaction.id),
              )
            : IconButton(
                icon: const Icon(
                  Icons.clear,
                  size: 20,
                ),
                color: Colors.redAccent[700],
                onPressed: () =>
                    widget._deleteTransaction(widget._userTransaction.id),
              ),
      ),
    );
  }
}
