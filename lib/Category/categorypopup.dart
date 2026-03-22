import 'package:chaching/db/category/categaoryfunction.dart';
import 'package:chaching/models/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

ValueNotifier<Categorytype> categorytypenotifier = ValueNotifier(
  Categorytype.income,
);

final _nametextcontroller = TextEditingController();

Future<void> categoryaddpopup(BuildContext context) async {
  showModalBottomSheet(
    useSafeArea: true,

    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(top: BorderSide(color: Colors.purple, width: 2.0)),
          color: Colors.black,
        ),
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 10,
          ),

          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // 👇 Top bar / drag handle
              Container(
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.purple,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(height: 15),

              Text(
                'Add Category',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              SizedBox(height: 15),
              TextField(
                style: TextStyle(color: Colors.white),
                controller: _nametextcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter Category Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    rediobutton(title: 'Income', type: Categorytype.income),
                    SizedBox(width: 20),
                    rediobutton(title: 'Expense', type: Categorytype.expense),
                  ],
                ),
              ),

              SizedBox(height: 15),

              ElevatedButton(
                onPressed: () {
                  final _name = _nametextcontroller.text;
                  if (_name.isEmpty) {
                    return;
                  }
                  final _type = categorytypenotifier.value;
                  final _category = Category(
                    id: DateTime.now().microsecondsSinceEpoch.toString(),
                    name: _name,
                    type: _type,
                  );
                  CategoryDb().insertCategory(_category);
                  Navigator.of(context).pop();
                  _nametextcontroller.clear();
                },
                child: Text('Add'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      );
    },
  );
}

class rediobutton extends StatelessWidget {
  final String title;
  final Categorytype type;
  const rediobutton({super.key, required this.title, required this.type});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: categorytypenotifier,
          builder:
              (BuildContext context, Categorytype newcategorytype, Widget? _) {
                return Radio<Categorytype>(
                  activeColor: Colors.purple,
                  value: type,
                  groupValue: newcategorytype,
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    } else {
                      categorytypenotifier.value = value;
                    }
                  },
                );
              },
        ),
        Text(title, style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
