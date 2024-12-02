import 'package:flutter/material.dart';

import '../login_page.dart'; // Імпортуйте ваші сторінки
import 'register_page.dart';
import 'profile_page.dart'; // Імпорт для сторінки профілю
import 'home_page.dart'; // Імпорт для головної сторінки

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(), // Додайте маршрут для профілю
        '/home': (context) =>
            HomePage(), // Додайте маршрут для головної сторінки
      },

    );
  }
}
