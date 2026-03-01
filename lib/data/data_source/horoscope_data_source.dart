import 'package:myapp/data/dto/daily_predict_dto.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class HoroscopeDataSource {
  Future<DailyPredictDto> getDailyPredict({required ZodiacSign sign});
}

/// Fetches daily predictions from Supabase table [daily_horoskopes].
/// Returns the latest row by date for the given sign (columns: id, sign, date, prediction).
final class HoroscopeSupabaseDataSource implements HoroscopeDataSource {
  static const _tableName = 'daily_horoscopes';

  final SupabaseClient _client;

  HoroscopeSupabaseDataSource({required SupabaseClient client})
    : _client = client;

  @override
  Future<DailyPredictDto> getDailyPredict({required ZodiacSign sign}) async {
    final response = await _client
        .from(_tableName)
        .select()
        .eq('sign', sign.name)
        .order('date', ascending: false)
        .limit(1)
        .maybeSingle();

    if (response == null) {
      throw Exception('No daily horoscope found for sign ${sign.name}');
    }

    final prediction = response['prediction'] as String?;
    if (prediction == null || prediction.isEmpty) {
      throw Exception('Horoscope row has no prediction text');
    }

    return DailyPredictDto.fromJson(response);
  }
}
