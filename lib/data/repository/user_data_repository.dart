import 'package:myapp/domain/entity/user.dart';
import 'package:myapp/domain/repository/user_repository.dart';

import 'dart:js_interop';

final class UserDataRepository implements UserRepository {
  const UserDataRepository();

  @override
  User? getUser() {
    final webApp = telegramWebApp as WebApp;
    final user = webApp.initDataUnsafe.user;

    if (user != null) {
      return User(
        id: user.id,
        firstName: user.firstName,
        lastName: user.lastName,
      );
    } else {
      return null;
    }
  }
}

@JS('Telegram.WebApp')
external JSObject get telegramWebApp;

extension type WebApp(JSObject _) implements JSObject {
  external WebAppInitData get initDataUnsafe;
}

extension type WebAppInitData(JSObject _) implements JSObject {
  external WebAppUser? get user;
}

extension type WebAppUser(JSObject _) implements JSObject {
  external int get id;

  @JS('first_name')
  external String get firstName;

  @JS('last_name')
  external String? get lastName;
}
