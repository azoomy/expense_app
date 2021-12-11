import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function removeTxn;

  TransactionList(this.transactions, this.removeTxn);

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: widget.transactions.isEmpty
          ? LayoutBuilder(builder: (ctx, constraints) {
              return Column(
                children: [
                  Text(
                    "No Transactions added yet.",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset('assets/images/waiting.png',
                        fit: BoxFit.contain),
                  ),
                ],
              );
            })
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Dismissible(
                  key: Key(widget.transactions[index].id),
                  onDismissed: (direction) {
                    widget.removeTxn(widget.transactions[index].id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(' Transaction deleted'),
                      ),
                    );
                  },
                  background: Container(color: Colors.red),
                  child: Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 5,
                    ),
                    child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                              child: Text(
                                '₹${widget.transactions[index].amount}',
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          widget.transactions[index].title,
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          DateFormat.yMMMd()
                              .format(widget.transactions[index].date),
                        ),
                        trailing: FlatButton.icon(
                          icon: Icon(Icons.keyboard_arrow_left_outlined),
                          label: Text('delete'),
                          textColor: Colors.red,
                        )),
                  ),
                );
              },
              itemCount: widget.transactions.length,
            ),
    );
  }
}
