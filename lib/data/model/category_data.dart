import 'package:hive/hive.dart';

part 'category_data.g.dart';

@HiveType(typeId: 2)
class CategoryData extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String description;

  CategoryData({
    required this.id,
    required this.description,
  });

  @override
  String toString() => 'CategoryData(id: $id, description: $description)';
}
