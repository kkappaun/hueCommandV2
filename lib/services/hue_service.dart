import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/hue_light.dart';

class HueService {
  static const String baseUrl = 'http://127.0.0.1:8081';

  Future<HueLight> getLight() async {
    final response = await http.get(
      Uri.parse('$baseUrl/lights'),
    );

    if (response.statusCode != 200) {
      throw Exception('Backend nicht erreichbar');
    }

    final json = jsonDecode(response.body);

    final light =
        json['lights']['32'] as Map<String, dynamic>;

    return HueLight.fromJson('32', light);
  }

  Future<void> setLight({
    required bool on,
    required int brightness,
  }) async {
    await http.get(
      Uri.parse(
        '$baseUrl/lights/32/${on ? 1 : 0}/$brightness',
      ),
    );
  }
}