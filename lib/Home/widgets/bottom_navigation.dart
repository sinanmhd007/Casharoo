import 'package:flutter/material.dart';

import '/Home/HomeScreen.dart';

class MoneyManagerBottomNavigator extends StatelessWidget {
  const MoneyManagerBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Homescreen.selectedIndexNotifier,
      builder: (ctx, updatedindex, _) {
        return BottomNavigationBar(
          currentIndex: updatedindex,
          onTap: (newIndex) {
            Homescreen.selectedIndexNotifier.value = newIndex;
          },
          backgroundColor: Colors.black,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          selectedIconTheme: IconThemeData(color: Colors.purple),
          unselectedIconTheme: IconThemeData(color: Colors.grey),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.payment),
              label: 'Transactions',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Category',
            ),
          ],
        );
      },
    );
  }
}
