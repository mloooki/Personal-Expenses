import 'package:My_App/models/Transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditTransactionSheet extends StatefulWidget {
  Transaction tx;
  final Function _deleteTx;
  final Function _addTx;

  EditTransactionSheet(this.tx, this._deleteTx, this._addTx);

  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransactionSheet> {
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _editTransactionValue(Transaction tx) {
    print('start = ' + tx.title + tx.date.toString() + tx.amount.toString());
    setState(() {
      //widget._deleteTx(tx.id);
    });
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
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
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
  int group = 0; // selected type
  @override
  Widget build(BuildContext context) {
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
                        });
                      }),
                ],
              ),

              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                //..text = widget.tx.amount.toString(),
                onSubmitted: (_) => _editData(),
              ),
              Container(
                height: 70,
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
              Row(
                children: <Widget>[
                  SizedBox(
                    width: 105,
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
  }
}
