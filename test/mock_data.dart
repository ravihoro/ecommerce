import 'package:ecommerce/data/models/product_model.dart';

var mockProducts = [
  {
    "id": 5,
    "title": "Product 1",
    "price": 100,
    "description": "This is product 1",
    "image": "https://example.com/product1.jpg",
    "category": "Category 1",
    "rating": {"rate": 4.5, "count": 10},
  }
];

var mockCategories = ['jewelery'];

var products = [for (final json in mockProducts) ProductModel.fromJson(json)];

var categories = [for (final cat in mockCategories) cat];
