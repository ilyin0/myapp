import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart' as material;
import 'package:myapp/data/data_source/telegram_web_app_data_source.dart';

import 'package:myapp/data/repository/user_data_repository.dart';
import 'package:myapp/domain/repository/user_repository.dart';

final class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final class _HomeScreenState extends State<HomeScreen> {
  final TelegramWebAppDataSource _telegramWebAppDataSource =
      TelegramWebAppDataSourceImpl();
  late final UserRepository _userRepository = UserDataRepository(
    _telegramWebAppDataSource,
  );

  String _info = "Press button to obtain user data";

  void showUserData() {
    final user = _userRepository.getUser();

    setState(() {
      if (user != null) {
        _info =
            "Name: ${user.firstName} ${user.lastName ?? ''}\nID: ${user.id}";
      } else {
        _info = "User data not found.\nRun in telegram!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return material.Scaffold(
      appBar: material.AppBar(title: const Text("User Data App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _info,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            material.ElevatedButton(
              onPressed: showUserData,
              child: const Text("Show data"),
            ),
          ],
        ),
      ),
    );
  }
}
