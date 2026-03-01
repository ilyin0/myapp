import 'package:myapp/data/data_source/horoscope_data_source.dart';
import 'package:myapp/domain/entity/daily_predict.dart';
import 'package:myapp/domain/entity/zodiac_sign.dart';
import 'package:myapp/domain/repository/horoscope_repository.dart';

final class HoroscopeDataRepository implements HoroscopeRepository {
  const HoroscopeDataRepository(this._dataSource);

  final HoroscopeDataSource _dataSource;

  @override
  Future<DailyPredict> getDailyPredict({required ZodiacSign sign}) async {
    final dailyPredictDto = await _dataSource.getDailyPredict(sign: sign);
    return DailyPredict(predict: dailyPredictDto.predict);
  }
}
