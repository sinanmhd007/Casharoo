import 'package:chaching/Category/categorypopup.dart';
import 'package:chaching/Home/widgets/bottom_navigation.dart';
import 'package:chaching/Transaction/screen/TransactionScreen.dart';
import 'package:chaching/category/CategoryScreen.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});
  static ValueNotifier<int> selectedIndexNotifier = ValueNotifier(0);

  final _pages = const [Transactionscreen(), Categoryscreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Text(
            'Casharoo',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            
          ),
          
        ),

        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: MoneyManagerBottomNavigator(),
      body: SafeArea(
        child: ValueListenableBuilder(
          valueListenable: selectedIndexNotifier,
          builder: (ctx, updated, _) {
            return _pages[updated];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedIndexNotifier.value == 0) {
            print('Add Transaction');
            Navigator.of(context).pushNamed('add-transaction');
          } else {
            print('Add Category');
            categoryaddpopup(context);
          }
        },
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
