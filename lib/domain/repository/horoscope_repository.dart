import 'package:myapp/domain/entity/daily_predict.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';

abstract interface class HoroscopeRepository {
  Future<DailyPredict> getDailyPredict({required ZodiacSign sign});
}
