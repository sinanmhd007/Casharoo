import 'package:chaching/Transaction/model/Transactionmodel.dart';
import 'package:chaching/db/category/categaoryfunction.dart';
import 'package:chaching/db/category/transactionfunction.dart';
import 'package:chaching/models/categorymodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

class Screenaddtransaction extends StatefulWidget {
  const Screenaddtransaction({super.key});
  static const routeName = 'add-transaction';

  @override
  State<Screenaddtransaction> createState() => _ScreenaddtransactionState();
}

class _ScreenaddtransactionState extends State<Screenaddtransaction> {
  late Categorytype? _currentlyselectedvalue;
  Category? _categoryselectedmodel;
  String? _SelectedID;
  DateTime? _selectedDate;

  final _purposetextcontroller = TextEditingController();
  final _amounttextcontroller = TextEditingController();

  @override
  void initState() {
    _currentlyselectedvalue = Categorytype.income;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back, color: Colors.purple),
        ),
        title: Text(
          'Add Transaction',
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                keyboardType: TextInputType.text,
                controller: _purposetextcontroller,

                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Purpose',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number, // <-- show number keyboard
                controller: _amounttextcontroller,

                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter Amount',
                  hintStyle: TextStyle(color: Colors.grey),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.purple),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: const Color.fromARGB(255, 233, 233, 233),
                    ),
                  ),
                  prefixText: '₹',
                  prefixStyle: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),

              SizedBox(height: 20),

              Container(
                decoration: BoxDecoration(
                  color: const Color.fromARGB(107, 53, 53, 53),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Radio(
                          value: Categorytype.income,
                          groupValue: _currentlyselectedvalue,
                          onChanged: (newvalue) {
                            setState(() {
                              _currentlyselectedvalue = newvalue!;
                              _SelectedID = null;
                            });
                          },
                          activeColor: Colors.purple,
                        ),
                        Text('Income', style: TextStyle(color: Colors.white)),
                      ],
                    ),

                    Row(
                      children: [
                        Radio(
                          value: Categorytype.expense,
                          groupValue: _currentlyselectedvalue,
                          onChanged: (newvalue) {
                            setState(() {
                              _currentlyselectedvalue = newvalue!;
                              _SelectedID = null;
                            });
                          },
                          activeColor: Colors.purple,
                        ),
                        Text('Expense', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(107, 53, 53, 53),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(),
                  ),
                  child: TextButton.icon(
                    onPressed: () async {
                      // Pick date
                      final pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now().subtract(
                          const Duration(days: 30),
                        ),
                        lastDate: DateTime.now().add(const Duration(days: 30)),
                      );

                      if (pickedDate == null) return;

                      // Pick time
                      final pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (pickedTime == null) return;

                      // Combine date & time
                      final combinedDateTime = DateTime(
                        pickedDate.year,
                        pickedDate.month,
                        pickedDate.day,
                        pickedTime.hour,
                        pickedTime.minute,
                      );

                      setState(() {
                        _selectedDate = combinedDateTime;
                      });
                    },
                    icon: Icon(
                      Icons.calendar_today,
                      color: Colors.purple,
                      size: 19,
                    ),
                    label: Text(
                      _selectedDate == null
                          ? 'Select Date & Time'
                          : DateFormat(
                              'dd MMM yyyy • hh:mm a',
                            ).format(_selectedDate!),
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              DropdownButtonHideUnderline(
                child: DropdownButton2<String>(
                  value: _SelectedID,
                  isExpanded: true,
                  hint: Text(
                    'Select Category',
                    style: TextStyle(color: Colors.white),
                  ),
                  dropdownStyleData: DropdownStyleData(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 0, 0),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.purple),
                    ),
                    maxHeight: 200,
                  ),
                  buttonStyleData: ButtonStyleData(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(107, 53, 53, 53),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 12),
                  ),
                  iconStyleData: IconStyleData(iconEnabledColor: Colors.purple),
                  items:
                      (_currentlyselectedvalue == Categorytype.income
                              ? CategoryDb().incomeCategoryNotifier
                              : CategoryDb().expenseCategoryNotifier)
                          .value
                          .map((e) {
                            return DropdownMenuItem(
                              //return dropdown
                              value: e.id,
                              child: Text(
                                e.name,
                                style: TextStyle(color: Colors.white),
                              ),
                              onTap: () {
                                setState(() {
                                  _categoryselectedmodel = e;
                                });
                              },
                            );
                          })
                          .toList(),
                  onChanged: (selectedvalue) {
                    setState(() {
                      _SelectedID = selectedvalue;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  addtransaction(context);
                  _purposetextcontroller.clear();
                  _amounttextcontroller.clear();
                  _selectedDate = null;
                  _categoryselectedmodel = null;
                  _SelectedID = null;
                },
                label: Text('Add Transaction'),
                icon: Icon(Icons.add_outlined),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addtransaction(BuildContext context) async {
    final _purpose = _purposetextcontroller.text;
    final _amount = _amounttextcontroller.text;
    if (_purpose.isEmpty || _amount.isEmpty) {
      return;
    }
    if (_selectedDate == null) {
      return;
    }
    if (_SelectedID == null) {
      return;
    }
    if (_categoryselectedmodel == null) {
      return;
    }

    final _parsedAmount = double.tryParse(_amount);
    if (_parsedAmount == null) {
      return;
    }

    final _transactionmodel = Transactionmodel(
      purpose: _purpose,
      amount: _parsedAmount,
      date: _selectedDate!,
      type: _currentlyselectedvalue!,

      category: _categoryselectedmodel!,
    );

    transaction().addTransaction(_transactionmodel);
    Navigator.of(context).pop();
  }
  
  
}
