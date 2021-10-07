import 'package:organeasy/data/model/category_data.dart';

class CategoryRepository {
  final categoryList = [
    CategoryData(id: 0, description: "Receitas"),
    CategoryData(id: 1, description: "Aposentadoria"),
    CategoryData(id: 2, description: "Reserva de Emergência"),
    CategoryData(id: 3, description: "Necessidades"),
    CategoryData(id: 4, description: "Lazer"),
    CategoryData(id: 5, description: "Doação"),
    CategoryData(id: 1337, description: "Objetivos"),
  ];

  Future<List<CategoryData>> getCategoryList() async {
    await Future.delayed(Duration(seconds: 1));
    return Future.value(categoryList);
  }
}
