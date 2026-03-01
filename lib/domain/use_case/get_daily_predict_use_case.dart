import 'package:myapp/domain/entity/daily_predict.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';
import 'package:myapp/domain/repository/horoscope_repository.dart';

final class GetDailyPredictUseCase {
  const GetDailyPredictUseCase(this._repository);

  final HoroscopeRepository _repository;

  Future<DailyPredict> call({required ZodiacSign sign}) =>
      _repository.getDailyPredict(sign: sign);
}
