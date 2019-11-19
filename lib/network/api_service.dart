import 'dart:convert';

import 'package:flutter_workshop/config.dart';
import 'package:http/http.dart' as http;

import 'model/point_api_model.dart';

class ApiService {

  final Config _config;

  ApiService(this._config);

  Future<List<PointApiModel>> getNearbyPoints(double lat, double lng, String query) async {
    final qParams = <String, String>{
      'client_id': _config.clientId,
      'client_secret': _config.clientSecret,
      'v': '20180323',
      'll': '$lat,$lng',
      'query': query,
      'limit': '100'
    };

    final url = Uri.https(_config.baseUrl, '/v2/venues/explore', qParams);
    final response = await http.get(url);
    final body = json.decode(response.body);

    final groups = body['response']['groups'];
    final items = groups[0]['items'];
    final venues = items.map((item) => item['venue']);

    final result = <PointApiModel>[];
    for (var venue in venues) {
      final model = PointApiModel.fromJson(venue);
      result.add(model);
    }
    return result;
  }
}
