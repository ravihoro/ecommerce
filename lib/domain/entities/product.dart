import 'package:ecommerce/data/models/product_model.dart';
import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String category;
  final String description;
  final double price;
  final String image;
  final Rating rating;

  const Product({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
  });

  factory Product.fromModel(ProductModel model) {
    return Product(
      id: model.id,
      category: model.category,
      title: model.title,
      description: model.description,
      price: model.price,
      image: model.image,
      rating: Rating.fromModel(model.rating),
    );
  }

  ProductModel toProductModel() {
    return ProductModel(
      id: id,
      title: title,
      price: price,
      description: description,
      category: category,
      image: image,
      rating: rating.toRatingModel(),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        price,
        image,
        rating,
        category,
      ];
}

class Rating extends Equatable {
  final double rate;
  final int count;

  const Rating({
    required this.rate,
    required this.count,
  });

  factory Rating.fromModel(RatingModel model) {
    return Rating(
      rate: model.rate,
      count: model.count,
    );
  }

  RatingModel toRatingModel() {
    return RatingModel(rate: rate, count: count);
  }

  @override
  List<Object?> get props => [
        rate,
        count,
      ];
}
