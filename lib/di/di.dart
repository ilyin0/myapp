import 'package:myapp/data/data_source/horoscope_data_source.dart';
import 'package:myapp/data/data_source/telegram_web_app_data_source.dart';
import 'package:myapp/data/repository/horoscope_data_repository.dart';
import 'package:myapp/data/repository/user_data_repository.dart';
import 'package:myapp/domain/repository/user_repository.dart';
import 'package:myapp/domain/use_case/get_daily_predict_use_case.dart';
import 'package:http/http.dart' as http;

late final GetDailyPredictUseCase getDailyPredictUseCase;
late final UserRepository userRepository;

void initDi() {
  // Horoscope Feature
  final httpClient = http.Client();
  final horoscopeDataSource = HoroscopeRemoteDataSource(client: httpClient);
  final horoscopeRepository = HoroscopeDataRepository(horoscopeDataSource);
  getDailyPredictUseCase = GetDailyPredictUseCase(horoscopeRepository);

  // User Feature
  final TelegramWebAppDataSource telegramDataSource = TelegramWebAppDataSourceImpl();
  userRepository = UserDataRepository(telegramDataSource);
}
