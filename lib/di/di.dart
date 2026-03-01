import 'package:myapp/data/data_source/horoscope_data_source.dart';
import 'package:myapp/data/data_source/telegram_web_app_data_source.dart';
import 'package:myapp/data/repository/horoscope_data_repository.dart';
import 'package:myapp/data/repository/user_data_repository.dart';
import 'package:myapp/domain/repository/user_repository.dart';
import 'package:myapp/domain/use_case/get_daily_predict_use_case.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

late final GetDailyPredictUseCase getDailyPredictUseCase;
late final UserRepository userRepository;

void initDi() {
  // Horoscope Feature (Supabase: daily_horoskopes, latest by date per sign)
  final horoscopeDataSource = HoroscopeSupabaseDataSource(
    client: Supabase.instance.client,
  );
  final horoscopeRepository = HoroscopeDataRepository(horoscopeDataSource);
  getDailyPredictUseCase = GetDailyPredictUseCase(horoscopeRepository);

  // User Feature
  final TelegramWebAppDataSource telegramDataSource = TelegramWebAppDataSourceImpl();
  userRepository = UserDataRepository(telegramDataSource);
}
