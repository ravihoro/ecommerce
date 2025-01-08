import 'package:ecommerce/core/database_helper.dart';
import 'package:ecommerce/core/exceptions.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:sqflite/sqflite.dart';

abstract class FavoriteDataSource {
  Future<void> addFavorite(ProductModel product);
  Future<void> removeFavorite(int id);
  Future<List<ProductModel>> getFavorites();
}

class LocalFavoriteDataSource extends FavoriteDataSource {
  final DatabaseHelper dbHelper;

  final table = 'favorites';

  LocalFavoriteDataSource(this.dbHelper);

  @override
  Future<void> addFavorite(ProductModel product) async {
    final db = await dbHelper.database;

    int rowsAffected = await db.insert(
      table,
      {
        'id': product.id,
        'title': product.title,
        'price': product.price,
        'description': product.description,
        'category': product.category,
        'image': product.image,
        'rate': product.rating.rate,
        'count': product.rating.count,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    if (rowsAffected == 0) throw DatabaseInsertException();
  }

  @override
  Future<List<ProductModel>> getFavorites() async {
    final db = await dbHelper.database;

    try {
      final result = await db.query(table);

      return result.map((r) {
        return ProductModel(
          id: r['id'] as int,
          title: r['title'] as String,
          price: r['price'] as double,
          description: r['description'] as String,
          category: r['category'] as String,
          image: r['image'] as String,
          rating: RatingModel(
            rate: r['rate'] as double,
            count: r['count'] as int,
          ),
        );
      }).toList();
    } catch (e) {
      throw DatabaseFetchException();
    }
  }

  @override
  Future<void> removeFavorite(int id) async {
    final db = await dbHelper.database;

    final rowsAffected =
        await db.delete(table, where: 'id = ?', whereArgs: [id]);

    if (rowsAffected == 0) throw DatabaseDeleteException();
  }
}
