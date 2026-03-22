import 'package:hive_flutter/hive_flutter.dart';
part 'categorymodel.g.dart';
@HiveType(typeId: 2)
enum Categorytype {
  @HiveField(0)
  income,
  @HiveField(1)
  expense,
}

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final Categorytype type;

  Category({required this.id, required this.name, required this.type});
}
