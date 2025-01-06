import 'dart:convert';

import 'package:ecommerce/core/constants.dart';
import 'package:ecommerce/data/data_source/product_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import '../../mock_data.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late RemoteProductDataSource dataSource;

  setUp(() {
    client = MockClient();
    dataSource = RemoteProductDataSource(client);
  });

  test(
    'test fetch products successfully',
    () async {
      when(() => client.get(Uri.parse(BASE_URL))).thenAnswer(
        (_) async => http.Response(jsonEncode(mockProducts), 200),
      );

      var response = await dataSource.getAllProducts();

      expect(response, mockProducts);
    },
  );

  test('throw exception when error', () {
    when(() => client.get(Uri.parse(BASE_URL))).thenAnswer(
      (_) async => http.Response(jsonEncode({}), 404),
    );

    expect(() async => await dataSource.getAllProducts(), throwsException);
  });

  test("test successfully fetch categories", () async {
    when(() => client.get(Uri.parse("$BASE_URL/categories"))).thenAnswer(
      (_) async => http.Response(jsonEncode(mockCategories), 200),
    );

    var response = await dataSource.getCategories();

    verify(() => client.get(Uri.parse("$BASE_URL/categories"))).called(1);

    expect(response, mockCategories);
  });

  test(
    'test successfully fetch category products',
    () async {
      when(() => client.get(Uri.parse("$BASE_URL/category/jewelery")))
          .thenAnswer(
        (_) async => http.Response(jsonEncode(mockProducts), 200),
      );

      var response = await dataSource.getProductsByCategory("jewelery");

      verify(() => client.get(Uri.parse("$BASE_URL/category/jewelery")))
          .called(1);

      expect(response, mockProducts);
    },
  );
}
