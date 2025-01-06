import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final RatingModel rating;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'],
      price: double.parse(json['price'].toString()),
      description: json['description'],
      category: json['category'],
      image: json['image'],
      rating: RatingModel.fromJson(json['rating']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        price,
        description,
        category,
        image,
        rating,
      ];
}

class RatingModel extends Equatable {
  final double rate;
  final int count;

  const RatingModel({
    required this.rate,
    required this.count,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      rate: json['rate'].toDouble(),
      count: json['count'],
    );
  }

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
