import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expense',

      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.indigo, //secondary color
        fontFamily: 'Quicksand',
        textTheme:ThemeData.light().textTheme.copyWith(
             title: TextStyle(
               fontFamily: 'OpenSans',
               fontSize:18,
              fontWeight: FontWeight.bold, ),
              button: TextStyle(color: Colors.white),
        ),
        appBarTheme: AppBarTheme(
          textTheme:ThemeData.light().textTheme.copyWith(
             title: TextStyle(
               fontFamily: 'OpenSans',
               fontSize:20,
              fontWeight: FontWeight.bold,
             )
          )
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 't1',
    //   name: 'New Shoes',
    //   amount: 69.99,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   name: 'Weekly Groceries',
    //   amount: 16.53,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showchaet= false;
   void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: NewTransactions(_addNewTransaction),
          behavior: HitTestBehavior.opaque,
        );
      },
    );
  }
 
  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx){
    return tx.date.isAfter(
      DateTime.now().subtract(Duration(days: 7),),
    ); 
       }).toList();
  }

  void _addNewTransaction(String txTitle, double txAmount, DateTime selctedDate) {
    final newTx = Transaction(
      name: txTitle,
      amount: txAmount,
      date: selctedDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

 
  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id==id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape=MediaQuery.of(context).orientation==Orientation.landscape;
      final appBar=AppBar(                         //turning AppBar into a variable so that we can get its heaight 
            title: Text('Personal Expense'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          );
    final txlist= Container(
                height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,

              child: TransactionList(_userTransactions,_deleteTransaction));
   
    
        return Scaffold(
          appBar: appBar,
          body: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
           if(isLandscape) Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Text('Show Chart'),
                  Switch(value: _showchaet, onChanged: (val){
                    setState(() {
                      _showchaet=val;
                    });
                  })
            ],) ,
           if(!isLandscape)   Container(
             height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.3,
             child: Chart(_recentTransactions)),
            if(!isLandscape)txlist,
       if(isLandscape)_showchaet ?     Container(
             height: (MediaQuery.of(context).size.height-appBar.preferredSize.height-MediaQuery.of(context).padding.top)*0.7,
             child: Chart(_recentTransactions))
             :txlist
             
               ],
               ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

  List<Transaction> buildRecentTransactions() => _recentTransactions;
}
