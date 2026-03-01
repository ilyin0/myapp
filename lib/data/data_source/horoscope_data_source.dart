import 'dart:convert';

import 'package:myapp/data/dto/daily_predict_dto.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';
import 'package:http/http.dart' as http;

abstract interface class HoroscopeDataSource {
  Future<DailyPredictDto> getDailyPredict({required ZodiacSign sign});
}

final class HoroscopeRemoteDataSource implements HoroscopeDataSource {
  final http.Client _client;

  HoroscopeRemoteDataSource({required http.Client client}) : _client = client;

  @override
  Future<DailyPredictDto> getDailyPredict({required ZodiacSign sign}) async {
    final response = await _client.post(
      Uri.parse('https://aztro.sameerkumar.website/?sign=${sign.name}&day=today'),
    );

    if (response.statusCode == 200) {
      return DailyPredictDto.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load horoscope');
    }
  }
}
