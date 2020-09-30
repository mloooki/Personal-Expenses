import 'models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './edit_transaction_sheet.dart';

class TransactionCard extends StatefulWidget {
  List<Transaction> _transactionList;
  final Function _deleteTx;
  final Function _addTx;

  TransactionCard(
    @required this._transactionList,
    this._deleteTx,
    this._addTx,
  );

  void _startEditTransaction(BuildContext ctx, Transaction tx) {
    showBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransactionSheet(tx, _deleteTx, _addTx);
        });
  }

  @override
  _TransactionCardState createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  final Color _cardTextColor = Colors.white;

/*   void _startEditTransaction(BuildContext ctx, Transaction tx) {
    showBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransactionSheet(tx, _editTransactionValue);
        });
  }

  void _editTransactionValue(Transaction tx) {
    setState(() {
      print('Hi editTransactionValue setState() and tx =');
      print(tx.title);
      widget._transactionList.removeWhere((element) => element.id == tx.id);
      widget._transactionList.add(tx);
    });
  } */

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget._transactionList.map((tx) {
        return Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          elevation: 8,
          margin: EdgeInsets.fromLTRB(8, 8, 8, 10),
          color: Theme.of(context).primaryColor,
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 10, 17),
                width: 110,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      tx.icon.icon,
                      color: _cardTextColor,
                      size: 40,
                    ),
                    Text(
                      tx.title,
                      style: TextStyle(
                          color: _cardTextColor, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '\$' + tx.amount.toStringAsFixed(2),
                    style: TextStyle(
                        color: _cardTextColor, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    DateFormat.yMMMd().format(tx.date),
                    style: TextStyle(color: _cardTextColor),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              IconButton(
                icon: Icon(Icons.edit),
                color: _cardTextColor,
                onPressed: () => widget._startEditTransaction(context, tx),
              ),
              SizedBox(
                width: 15,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                color: Colors.redAccent,
                onPressed: () => widget._deleteTx(tx.id),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
