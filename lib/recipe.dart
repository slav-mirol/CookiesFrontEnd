import 'package:test1/product.dart';

class Recipe {
  String name;
  String description;
  String photo;
  String video;
  String date;
  List<Product> products;

  Recipe(
      {required this.name,
      required this.description,
      required this.photo,
      required this.video,
      required this.date,
      required this.products
      }
      );
}