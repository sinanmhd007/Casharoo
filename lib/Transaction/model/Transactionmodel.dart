import 'package:chaching/models/categorymodel.dart';
import 'package:hive_flutter/hive_flutter.dart';
part 'Transactionmodel.g.dart';


@HiveType(typeId: 3)
class Transactionmodel {
  
  @HiveField(0)
  final String purpose;
  
  @HiveField(1)
  final double amount;
  
  @HiveField(2)
  final DateTime date;
  
  @HiveField(3) 
  final Categorytype type;
  
  @HiveField(4)
  final Category category;
  @HiveField(5)
   String? id;

  Transactionmodel({
    required this.purpose,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
   
  }){
    id = DateTime.now().microsecondsSinceEpoch.toString();
  }
  

}