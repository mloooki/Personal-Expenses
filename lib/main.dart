import 'dart:io';

import 'package:My_App/add_new_transaction_sheet.dart';
import 'package:My_App/edit_transaction_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'models/Transaction.dart';
//import './transaction_card.dart';
//import './transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // to ensure we run the DB code before the app start.
  Directory document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  await Hive.openBox("transaction");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groceries Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        accentColor: Colors.amber,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Personal Expenses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final DBTransactionManager dbmanager = new DBTransactionManager()
  Box transactionBox;
  final Color _cardTextColor = Colors.white;
  //final List<Transaction> _transactionList = [];
/*     Transaction(DateTime.now().toString(), 'Groceries', 55, DateTime.now(),
        Icon(Icons.local_grocery_store)),
    Transaction(DateTime.now().toString(), 'Bills', 45, DateTime.now(),
        Icon(Icons.data_usage)),
    Transaction(DateTime.now().toString(), 'Cloting', 55, DateTime.now(),
        Icon(Icons.accessibility_new)),
    Transaction(DateTime.now().toString(), 'Transporation', 15, DateTime.now(),
        Icon(Icons.train)),
    Transaction(DateTime.now().toString(), 'Other', 5, DateTime.now(),
        Icon(Icons.monetization_on)),
    Transaction(DateTime.now().toString(), 'Groceries', 55, DateTime.now(),
        Icon(Icons.local_grocery_store)),
    Transaction(DateTime.now().toString(), 'Bills', 45, DateTime.now(),
        Icon(Icons.data_usage)),
    Transaction(DateTime.now().toString(), 'Cloting', 35, DateTime.now(),
        Icon(Icons.accessibility_new)),
    Transaction(DateTime.now().toString(), 'Transporation', 15, DateTime.now(),
        Icon(Icons.train)),
    Transaction(DateTime.now().toString(), 'Other', 5, DateTime.now(),
        Icon(Icons.monetization_on)),
    Transaction(DateTime.now().toString(), 'Groceries', 55, DateTime.now(),
        Icon(Icons.local_grocery_store)),
    Transaction(DateTime.now().toString(), 'Bills', 45, DateTime.now(),
        Icon(Icons.data_usage)),
    Transaction(DateTime.now().toString(), 'Cloting', 35, DateTime.now(),
        Icon(Icons.accessibility_new)),
    Transaction(DateTime.now().toString(), 'Transporation', 25, DateTime.now(),
        Icon(Icons.directions_car)),
    Transaction(DateTime.now().toString(), 'Other', 5, DateTime.now(),
        Icon(Icons.monetization_on)), */
  //];

  // refreshList() {
  // setState(() {
  // _transactionList = dbbHelper.getTransactions();
  // });
  //}

  Map<String, double> getTransactionmap(List<Transaction> txs) {
    //maybe I can conver this method to get type.
    //to convert List <Transaction> to Map <String, double>.
    final List<String> types = [
      'Groceries',
      "Bills",
      "Cloting",
      "Transporation",
      "Other",
    ];
    List<double> total = [
      0,
      0,
      0,
      0,
      0,
    ];
    for (int i = 0; i < txs.length; i++) {
      if (txs[i].title == types[0])
        total[0] += txs[i].amount;
      else if (txs[i].title == types[1])
        total[1] += txs[i].amount;
      else if (txs[i].title == types[2])
        total[2] += txs[i].amount;
      else if (txs[i].title == types[3])
        total[3] += txs[i].amount;
      else if (txs[i].title == types[4])
        total[4] += txs[i].amount;
      else
        print("Eorror");
    }

    Map<String, double> dataMap2 = {
      types[0]: total[0],
      types[1]: total[1],
      types[2]: total[2],
      types[3]: total[3],
      types[4]: total[4],
    };
    return dataMap2;
  }

  @override
  void initState() {
    super.initState();
    transactionBox = Hive.box('transaction');
  }

  int getTotal(List<Transaction> txs) {
    //get the total of all Transactions.
    double total = 0;
    for (int i = 0; i < txs.length; i++) total += txs[i].amount;
    return total.round();
  }

  Icon _getCorrectIcon(String title) {
    switch (title) {
      case 'Groceries':
        return Icon(Icons.local_grocery_store);
      case 'Bills':
        return Icon(Icons.data_usage);
      case 'Cloting':
        return Icon(Icons.accessibility_new);
      case 'Transporation':
        return Icon(Icons.directions_car);
      case 'Other':
        return Icon(Icons.monetization_on);
    }
  }

  void _deleteTransaction(String id) {
    print('Hi delete me please my id is : $id');

    setState(() {
      //_transactionList.removeWhere((element) => element.id == id);
      transactionBox.delete(id);
    });
  }

  List getTransactionsList() {
    List<Transaction> transaction = [];
    for (int i = 0; i < transactionBox.length; i++) {
      final key = transactionBox.keys.toList()[i];
      final value = transactionBox.get(key);
      final tx = Transaction(
          key, value[0], value[1], value[2], _getCorrectIcon(value[0]));
      transaction.add(tx);
    }
    return transaction;
  }

  Transaction _getOneTransaction(String id) {
    final values = transactionBox.get(id);
    print(values);
    final Transaction x = Transaction(
        id, values[0], values[1], values[2], _getCorrectIcon(values[0]));
    return x;
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      DateTime.now().toString(),
      title,
      amount,
      chosenDate,
      _getCorrectIcon(title),
    );
    final key = newTx.id;
    setState(() {
      //_transactionList.add(newTx);
      transactionBox.put(key, [newTx.title, newTx.amount, newTx.date]);

      print("New Transaction Added:");
      print(transactionBox.get(key));
      //print(transactionBox.getAt(0));
    });
  }

  void _startEditTransaction(BuildContext ctx, String id) {
    final Transaction x = _getOneTransaction(id);
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransactionSheet(
              x, _deleteTransaction, _addNewTransaction);
        });
  }

  void _startAddNreTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddNewTransactionSheet(
            _addNewTransaction,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final appBar = AppBar(
      title: Text(widget.title),
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: <Widget>[
          Container(
            height: (mediaQuery.size.height -
                    appBar.preferredSize.height -
                    mediaQuery.padding.top) *
                0.35,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: PieChart(
              dataMap: getTransactionmap(getTransactionsList()),
              animationDuration: Duration(seconds: 1),
              chartType: ChartType.ring,
              ringStrokeWidth: 11,
              chartLegendSpacing: 20,
              centerText:
                  'TOTAL=' + getTotal(getTransactionsList()).toString() + '\$',
              legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValuesInPercentage: true,
              ),
            ),
          ),
          getTransactionsList().isEmpty
              ? Container(
                  margin: EdgeInsets.all(55),
                  child: Text(
                    "No Transactions added !! Please click on plus button to add one.",
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: 19),
                  ),
                )
              : Container(
                  height: (mediaQuery.size.height -
                          appBar.preferredSize.height -
                          mediaQuery.padding.top) *
                      0.59,
                  //margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //decoration: BoxDecoration(border: Border.all(color: Colors.black)),

                  child: ValueListenableBuilder(
                    valueListenable: transactionBox.listenable(),
                    builder: (context, Box transation, _) {
                      return ListView.separated(
                        reverse: true,
                        itemBuilder: (context, index) {
                          final key = transation.keys.toList()[index];
                          final value = transation.get(key);
                          //print(value);

                          return LayoutBuilder(
                            builder: (context, constraints) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                elevation: 8,
                                margin: EdgeInsets.fromLTRB(8, 8, 8, 10),
                                color: Theme.of(context).primaryColor,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      margin:
                                          EdgeInsets.fromLTRB(20, 10, 10, 17),
                                      width: constraints.maxWidth * .25,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            _getCorrectIcon(value[0]).icon,
                                            color: _cardTextColor,
                                            size: 40,
                                          ),
                                          Text(
                                            value[0],
                                            style: TextStyle(
                                                color: _cardTextColor,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          width: constraints.maxWidth * 0.25,
                                          child: Text(
                                            '\$' + value[1].toStringAsFixed(2),
                                            style: TextStyle(
                                                color: _cardTextColor,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          DateFormat.yMMMd().format(value[2]),
                                          style:
                                              TextStyle(color: _cardTextColor),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.05,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      color: _cardTextColor,
                                      onPressed: () =>
                                          _startEditTransaction(context, key),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.05,
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      color: Colors.redAccent,
                                      onPressed: () => _deleteTransaction(key),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        separatorBuilder: (_, index) => Divider(),
                        itemCount: transation.keys.toList().length,
                      );
                    },
                  ),
                ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNreTransaction(context),
      ),
    );
  }
}
