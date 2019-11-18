import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/point_api_model.dart';

class ApiService {
  static const _BASE_URL = 'api.foursquare.com';

  //TODO move this to config
  static const _CLIENT_ID = 'UBZ3XRY2P1ARGZ0NBUTH1ITMBLLIF110XZCH2DIA4BM5G3UQ';
  static const _CLIENT_SECRET = 'Y4VHSYW4B4PL44S5Y5ZJAVTV2HQAUOELSQLDWBZ1QHARQ0ZC';

  Future<List<PointApiModel>> getNearbyPoints(double lat, double lng, String query) async {
    final qParams = <String, String>{
      'client_id': _CLIENT_ID,
      'client_secret': _CLIENT_SECRET,
      'v': '20180323',
      'll': '$lat,$lng',
      'query': query,
      'limit': '100'
    };

    final url = Uri.https(_BASE_URL, '/v2/venues/explore', qParams);
    final response = await http.get(url);
    final body = json.decode(response.body);

    final items = body['response']['groups'][0]['items'];
    final result = <PointApiModel>[];
    for (var item in items) {
      final model = PointApiModel.fromJson(item['venue']);
      result.add(model);
    }
    return result;
  }
}
