import 'package:chaching/db/category/categaoryfunction.dart';
import 'package:flutter/material.dart';
import 'package:chaching/Category/tab_bar_items/Expensecate.dart';
import 'package:chaching/Category/tab_bar_items/Incomecate.dart';

class Categoryscreen extends StatefulWidget {
  const Categoryscreen({super.key});

  @override
  State<Categoryscreen> createState() => _CategoryscreenState();
}

class _CategoryscreenState extends State<Categoryscreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    CategoryDb().refreshUI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Padding(padding: EdgeInsets.all(2)),
        TabBar(
          controller: _tabController,
          indicatorColor: Colors.purple,

          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.purple,
          unselectedLabelColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),

          tabs: [
            Tab(text: 'Income'),
            Tab(text: 'Expense'),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [Incomecate(), Expensecate()],
          ),
        ),
      ],
    );
  }
}
