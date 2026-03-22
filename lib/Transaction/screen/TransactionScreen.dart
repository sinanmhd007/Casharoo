import 'package:chaching/db/category/transactionfunction.dart';
import 'package:chaching/models/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:chaching/db/category/categaoryfunction.dart';

class Transactionscreen extends StatefulWidget {
  const Transactionscreen({super.key});

  @override
  State<Transactionscreen> createState() => _TransactionscreenState();
}

class _TransactionscreenState extends State<Transactionscreen> {
  @override
  void initState() {
    transaction.instance.refreshUI();
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: transactionNotifier,
      builder: (context, newlist, child_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemBuilder: (ctx, index) {
              final newvalue = newlist[index];
              return Card(
                color: const Color.fromARGB(255, 39, 38, 38),
                child: ListTile(
                  contentPadding: EdgeInsets.only(left: 10),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: newvalue.type == Categorytype.income
                        ? Colors.green
                        : Colors.red,
                    child: Text(
                      newvalue.category.name,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                  title: Text(
                    newvalue.purpose,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(newvalue.date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '₹${newvalue.amount.toString()}',
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                      IconButton(
                        onPressed: () {
                          transaction.instance.deleteTransaction(newvalue.id!);
                        },
                        icon: Icon(Icons.delete, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (ctx, index) {
              return SizedBox(height: 20);
            },
            itemCount: newlist.length,
          ),
        );
      },
    );
  }
}
