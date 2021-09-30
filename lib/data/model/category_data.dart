import 'package:hive/hive.dart';

class CategoryData extends HiveObject {
  final int id;
  final String description;

  CategoryData({
    required this.id,
    required this.description,
  });

  @override
  String toString() => 'CategoryData(id: $id, description: $description)';
}
