import 'dart:io';

import 'package:flutter/material.dart';
import 'package:budgeting_app/Services/authentication.dart';
import 'package:budgeting_app/transaction_list.dart';
import 'package:budgeting_app/new_transaction.dart';
import 'package:budgeting_app/transactions.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget Plan',
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: Colors.black,
          fontFamily: 'Quicksand',
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )
              )
          ),
          textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )
          )
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final List<BudgetTransaction> _userTransactions = [ ];

  void _addNewTransaction(String title, double amount, DateTime chosenDate){
    print(chosenDate);
    final newTx = BudgetTransaction(title: title, amount: amount, id: DateTime.now().toString(), date: chosenDate);
   // Firestore.instance.collection('Transactions').document().setData({ 'title': 'transport', 'amount': '20','date':'12/12/2020' });
    setState(() {
      this._userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx){
    showModalBottomSheet(
        context: ctx,
        builder: (_){
          return NewTransaction(this._addNewTransaction);
        });
  }

  void _deleteTransaction(String id){
    setState(() {
      this._userTransactions.removeWhere((tx) => id == tx.id);
    });
  }

  List<BudgetTransaction> get recentTransactions{
    return _userTransactions.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Budget Plan',
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () => exit(0),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Chart(recentTransactions),
            TransactionList(this._userTransactions, this._deleteTransaction),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add), onPressed: () => _startAddNewTransaction(context),),
    );
  }
}