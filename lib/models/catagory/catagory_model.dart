

import 'package:hive_flutter/hive_flutter.dart';
part 'catagory_model.g.dart';

@HiveType(typeId: 2)
enum CatagoryType{
  @HiveField(0)
  income,

  @HiveField(1)
  expense,
}


@HiveType(typeId: 1)
class CatagoryModel{
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isDeleted;

  @HiveField(3)
  final CatagoryType type;

CatagoryModel({required this.name,required this.type,this.isDeleted = false,required this.id});


@override 
String toString(){
  return '{$name $type}';
}

}