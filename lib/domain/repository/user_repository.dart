import 'package:myapp/domain/entity/user.dart';

abstract interface class UserRepository {
  User? getUser();
}
