import 'dart:convert';

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
