import 'package:myapp/data/data_source/telegram_web_app_data_source.dart';
import 'package:myapp/domain/entity/user.dart';
import 'package:myapp/domain/repository/user_repository.dart';

final class UserDataRepository implements UserRepository {
  const UserDataRepository(this._telegramWebAppDataSource);

  final TelegramWebAppDataSource _telegramWebAppDataSource;

  @override
  User? getUser() {
    final telegramUser = _telegramWebAppDataSource.getUser();
    return telegramUser != null
        ? User(
            id: telegramUser.id,
            firstName: telegramUser.firstName,
            lastName: telegramUser.lastName,
          )
        : null;
  }
}
