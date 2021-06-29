import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;
  TransactionList(this.transactions, this.deletetx);
  @override
  //this variable(transaction) will hold a list of transaction. @override
  Widget build(BuildContext context) {
    return Container(
      height: 450,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, contraints) {
                return Column(
                  children: [
                    Text(
                      'No Transactions added yet!',
                      style: Theme.of(context).textTheme.title,
                    ),
                    const SizedBox(
                      height: 10,
                    ), // this is used to provede spacing.
                    Container(
                        height: contraints.maxHeight * 0.7,
                        child: Image.asset(
                          'assets/images/waiting.png',
                          fit: BoxFit.cover,
                        )), //we need to wrap Image into a container as the Column don't have a fixed heigth
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                //here we can take any variable name for build conext and index ,as it provided for flutter, we don't have to worry about it
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: FittedBox(
                            child: Text('₹${transactions[index].amount}')),
                      ),
                    ),
                    title: Text(
                      transactions[index].name,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            onPressed: () => deletetx(transactions[index].id),
                            icon: const Icon(Icons.delete),
                            label: const Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                            )
                            
                        : IconButton(
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deletetx(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
