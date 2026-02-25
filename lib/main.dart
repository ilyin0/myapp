import 'package:flutter/material.dart';
import 'dart:js_interop';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: ThemeData.light(), home: const HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInfo = "Нажми кнопку, чтобы получить данные";

  void showUserData() {
    // Приводим глобальный объект к нашему типу WebApp
    final webApp = telegramWebApp as WebApp;
    final user = webApp.initDataUnsafe.user;

    setState(() {
      if (user != null) {
        // Обратите внимание: поля теперь доступны как обычные свойства Dart
        userInfo = "Имя: ${user.firstName} ${user.lastName ?? ''}\nID: ${user.id}";
      } else {
        userInfo = "Данные не найдены.\nЗапустите в Telegram!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Mini App")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              userInfo,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: showUserData,
              child: const Text("Показать данные"),
            ),
          ],
        ),
      ),
    );
  }
}

// Указываем Dart, что объект Telegram живет в глобальном окне (window)
@JS('Telegram.WebApp')
external JSObject get telegramWebApp;

// Описываем, какие поля мы хотим видеть у WebApp
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