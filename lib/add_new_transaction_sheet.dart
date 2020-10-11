import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddNewTransactionSheet extends StatefulWidget {
  final Function addTx;

  AddNewTransactionSheet(this.addTx);

  @override
  _AddNewTransactionSheetState createState() => _AddNewTransactionSheetState();
}

class _AddNewTransactionSheetState extends State<AddNewTransactionSheet> {
  //final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitDate() {
    //final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(types[group], enteredAmount, _selectedDate);

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
                    onSubmitted: (_) => _submitDate(),
                    keyboardType: TextInputType.number,
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
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: constraints.maxWidth * .31,
                      ),
                      RaisedButton(
                        child: Text(
                          'Add Transation',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Theme.of(context).primaryColor,
                        onPressed: _submitDate,
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
