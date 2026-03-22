import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chaching/db/category/categaoryfunction.dart';

class Incomecate extends StatelessWidget {
  const Incomecate({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: CategoryDb().incomeCategoryNotifier,
      builder: (context, newlist, child_) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            itemBuilder: (context, index) {
              final category = newlist[index];
              return Card(
                color: const Color.fromARGB(255, 39, 38, 38),
                child: ListTile(
                  title: Text(
                    category.name,
                    style: TextStyle(color: Colors.white),
                  ),

                  leading: Icon(FontAwesomeIcons.coins, color: Colors.purple),
                  trailing: IconButton(
                    onPressed: () {
                      CategoryDb().deleteCategory(category.id);
                    },
                    icon: Icon(Icons.delete, color: Colors.grey),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: newlist.length,
          ),
        );
      },
    );
  }
}
