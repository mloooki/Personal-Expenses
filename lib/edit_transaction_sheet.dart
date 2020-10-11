import 'package:My_App/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTransactionSheet extends StatefulWidget {
  Transaction tx;
  final Function _deleteTx;
  final Function _addTx;
  double enteredAmount;

  EditTransactionSheet(this.tx, this._deleteTx, this._addTx);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransactionSheet> {
  int group; // selected type
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  int _getGroupNumer() {
    switch (widget.tx.title) {
      case "Groceries":
        return 0;
        break;
      case "Bills":
        return 1;
        break;
      case "Cloting":
        return 2;
        break;
      case "Transporation":
        return 3;
        break;
      case "Other":
        return 4;
        break;
      default:
        return 0;
    }
  }

  void _editTransactionValue(Transaction tx) {
    print('start = ' + tx.title + tx.date.toString() + tx.amount.toString());
    setState(() {
      //widget._deleteTx(tx.id);
    });
  }

  void _enterAmount() {
    final enteredAmount = double.parse(_amountController.text);
  }

  void _editData() {
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    //widget.editTx(types[group], enteredAmount, _selectedDate);
    print('inside _editData()= ' +
        _selectedDate.toString() +
        enteredAmount.toString() +
        types[group]);

    widget._deleteTx(widget.tx.id);
    widget._addTx(types[group], enteredAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePickr() {
    showDatePicker(
      context: context,
      initialDate: widget.tx.date,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        widget.tx.date = pickedDate;
      });
    });
  }

  final List<String> types = [
    'Groceries',
    'Bills',
    'Cloting',
    'Transporation',
    'Other'
  ];

  @override
  Widget build(BuildContext context) {
    print('Edit Transaction sheet build');
    _selectedDate = widget.tx.date;
    group = _getGroupNumer();
    return LayoutBuilder(
      builder: (ctx, constraints) {
        return SingleChildScrollView(
          child: Card(
            elevation: 10,
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: MediaQuery.of(context).viewInsets.bottom + 90,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //TextField(
                  //decoration: InputDecoration(labelText: 'Title'),
                  //controller: _titleController,
                  //onSubmitted: (_) => _submitDate(),
                  //),
                  Text(
                    "Transaction Type:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text('Groceries'),
                      Radio(
                          value: 0,
                          groupValue: group,
                          activeColor: Colors.red[300],
                          onChanged: (_) {
                            print(_);

                            setState(() {
                              group = _;
                              widget.tx.title = 'Groceries';
                            });
                          }),
                      Text('Bills'),
                      Radio(
                          value: 1,
                          groupValue: group,
                          activeColor: Colors.blue[400],
                          onChanged: (_) {
                            print(_);

                            setState(() {
                              group = _;
                              widget.tx.title = 'Bills';
                            });
                          }),
                      Text('Cloting'),
                      Radio(
                          value: 2,
                          groupValue: group,
                          activeColor: Colors.greenAccent,
                          onChanged: (_) {
                            print(_);

                            setState(() {
                              group = _;
                              widget.tx.title = 'Cloting';
                            });
                          }),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Transporation'),
                      Radio(
                          value: 3,
                          groupValue: group,
                          activeColor: Colors.amberAccent[100],
                          onChanged: (_) {
                            print(_);

                            setState(() {
                              group = _;
                              widget.tx.title = 'Transporation';
                            });
                          }),
                      Text('Other'),
                      Radio(
                          value: 4,
                          groupValue: group,
                          activeColor: Colors.deepPurple[300],
                          onChanged: (_) {
                            print(_);

                            setState(() {
                              group = _;
                              widget.tx.title = 'Other';
                            });
                          }),
                    ],
                  ),

                  Container(
                    height: constraints.maxHeight * 0.2,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            _selectedDate == null
                                ? "No Date chosen!"
                                : "Picked Date: ${DateFormat.yMd().format(_selectedDate)}",
                          ),
                        ),
                        FlatButton(
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'chose Date',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: _presentDatePickr,
                        )
                      ],
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: _amountController,
                    //..text = widget.tx.amount.toString(),
                    onSubmitted: (_) => _editData(),
                    keyboardType: TextInputType.number,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: constraints.maxWidth * 0.31,
                      ),
                      RaisedButton(
                        child: Text(
                          'EditTransation',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: _editData,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
