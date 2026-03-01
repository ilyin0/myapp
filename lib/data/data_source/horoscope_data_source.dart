import 'dart:convert';

import 'package:myapp/data/dto/daily_predict_dto.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';
import 'package:http/http.dart' as http;

abstract interface class HoroscopeDataSource {
  Future<DailyPredictDto> getDailyPredict({required ZodiacSign sign});
}

/// Uses horoscope-app-api.vercel.app (GET, no API key, CORS-friendly).
final class HoroscopeRemoteDataSource implements HoroscopeDataSource {
  static const _baseUrl =
      'https://horoscope-app-api.vercel.app/api/v1/get-horoscope/daily';

  final http.Client _client;

  HoroscopeRemoteDataSource({required http.Client client}) : _client = client;

  @override
  Future<DailyPredictDto> getDailyPredict({required ZodiacSign sign}) async {
    final uri = Uri.parse('$_baseUrl?sign=${sign.name}');
    try {
      final response = await _client.get(uri);
      if (response.statusCode != 200) {
        throw Exception(
          'Horoscope API error ${response.statusCode}: ${response.body.isNotEmpty ? response.body : "empty response"}',
        );
      }
      final data = json.decode(response.body) as Map<String, dynamic>;
      final horoscopeText = data['horoscope'] as String?;
      if (horoscopeText == null || horoscopeText.isEmpty) {
        throw Exception('Horoscope API returned no text');
      }
      return DailyPredictDto.fromJson({'description': horoscopeText});
    } on http.ClientException catch (e) {
      throw Exception('Network error: ${e.message}');
    }
  }
}
