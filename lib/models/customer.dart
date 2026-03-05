import 'package:hive/hive.dart';
part 'customer.g.dart';

@HiveType(typeId: 0)
class Customer extends HiveObject {
  Customer({required this.id, required this.name, required this.phone});

  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String phone;
}
