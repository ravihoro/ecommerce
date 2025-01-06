import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:ecommerce/core/exceptions.dart';
import 'package:ecommerce/core/failures.dart';
import 'package:http/http.dart' as http;

Future<T> getCall<T>(
  http.Client client,
  String url,
  T Function(dynamic) fromJson,
) async {
  final response = await client.get(Uri.parse(url));
  if (response.statusCode == 200 || response.statusCode == 304) {
    return fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load data');
  }
}

Future<Either<Failure, R>> getRepositoryCall<R, T>(
  Future<T> Function() getCall,
  R Function(dynamic) fromJson,
) async {
  try {
    final T response = await getCall();
    return Right(fromJson(response));
  } on ServerException catch (e) {
    return Left(ServerFailure(e.message));
  } catch (e) {
    return const Left(CustomFailure('Something went wrong'));
  }
}

String capitaliseFirstLetter(String str) {
  List<String> list = str.split(" ");
  for (int i = 0; i < list.length; i++) {
    if (list[i].isNotEmpty) {
      list[i] = list[i][0].toUpperCase() + list[i].substring(1);
    }
  }
  return list.join(" ");
}
