import 'dart:js_interop';

abstract interface class TelegramWebAppDataSource {
  TelegramWebAppUser? getUser();
}

final class TelegramWebAppDataSourceImpl implements TelegramWebAppDataSource {
  const TelegramWebAppDataSourceImpl();

  @override
  TelegramWebAppUser? getUser() {
    final webApp = telegramWebApp;
    if (webApp.isA<TelegramWebApp>()) {
      return (webApp as TelegramWebApp).initDataUnsafe.user;
    } else {
      return null;
    }
  }
}

@JS('Telegram.WebApp')
external JSObject get telegramWebApp;

extension type TelegramWebApp(JSObject _) implements JSObject {
  external TelegramWebAppInitData get initDataUnsafe;
}

extension type TelegramWebAppInitData(JSObject _) implements JSObject {
  external TelegramWebAppUser? get user;
}

extension type TelegramWebAppUser(JSObject _) implements JSObject {
  external int get id;

  @JS('first_name')
  external String get firstName;

  @JS('last_name')
  external String? get lastName;
}
