import 'package:My_App/add_new_transaction_sheet.dart';
import 'package:My_App/edit_transaction_sheet.dart';
import 'dart:async';
import 'models/Transaction.dart';
import './transaction_card.dart';
import './transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
//import './sqlite/db_helper.dart';

void main() {
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
  final Color _cardTextColor = Colors.white;
  final List<Transaction> _transactionList = [];
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
  //var dbbHelper;
  //List<Transaction> txss;
  //bool isUpdating;
  //@override
  // void initState() {
  // super.initState();
  //   dbbHelper = DBHelper();
  //  dbbHelper.getTransactions();
  //  isUpdating = false;
  // }

  //refreshList() {
  // setState(() {
  //  txss = dbbHelper.getTransactions();
  // });
  // }

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
      _transactionList.removeWhere((element) => element.id == id);
      //dbbHelper.delete(id);
    });
  }

  void _addNewTransaction(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      DateTime.now().toString(),
      title,
      amount,
      chosenDate,
      _getCorrectIcon(title),
    );

    setState(() {
      _transactionList.add(newTx);
      //dbbHelper.save(newTx);
    });
  }

  void _startEditTransaction(BuildContext ctx, Transaction tx) {
    showBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransactionSheet(
              tx, _editTransactionValue, _addNewTransaction);
        });
  }

  void _editTransactionValue(Transaction tx) {
    print('start = ' + tx.title + tx.date.toString() + tx.amount.toString());
    setState(() {
      _deleteTransaction(tx.id);
    });
  }

/*   void _editTransaction(Transaction editedTransaction) {
    print("hi i'm here :)");
    _transactionList
        .removeWhere((element) => element.id == editedTransaction.id);
    setState(() {
      _transactionList.add(editedTransaction);
    });
  } */

  void _startAddNreTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return AddNewTransactionSheet(_addNewTransaction);
        });
  }

/*   void _startEditTransaction(BuildContext ctx) {
    showBottomSheet(
        context: ctx,
        builder: (_) {
          return EditTransaction(_editTransaction);
        });
  } */

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
              dataMap: getTransactionmap(_transactionList),
              animationDuration: Duration(seconds: 1),
              chartType: ChartType.ring,
              ringStrokeWidth: 11,
              chartLegendSpacing: 20,
              centerText:
                  'TOTAL=' + getTotal(_transactionList).toString() + '\$',
              legendOptions: LegendOptions(
                  showLegendsInRow: false,
                  legendPosition: LegendPosition.right),
              chartValuesOptions: ChartValuesOptions(
                showChartValueBackground: false,
                showChartValuesInPercentage: true,
              ),
            ),
          ),
          _transactionList.isEmpty
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
                      0.58,
                  //margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  //decoration: BoxDecoration(border: Border.all(color: Colors.black)),

                  child: SingleChildScrollView(
                    child: TransactionCard(
                      _transactionList,
                      _deleteTransaction,
                      _addNewTransaction,
                    ),
                  )),
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
