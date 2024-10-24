import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';
import 'profile_page.dart';
import 'home_page.dart';
import 'edit_profile_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

abstract class UserRepository {
  Future<void> saveUser(String name, String email, String password);
  Future<Map<String, String>?> getUser(String email);
  Future<void> updateUser(String name, String email);
}

class LocalUserRepository implements UserRepository {
  @override
  Future<void> saveUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', password);
  }

  @override
  Future<Map<String, String>?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final savedEmail = prefs.getString('email');
    if (savedEmail == email) {
      final name = prefs.getString('name');
      return {
        'name': name ?? '',
        'email': savedEmail ?? '',
      };
    }
    return null;
  }

  @override
  Future<void> updateUser(String name, String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
  }
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
        '/home': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String;
          return HomePage(email: email);
        },
        '/profile': (context) {
          final email = ModalRoute.of(context)!.settings.arguments as String;
          return FutureBuilder<Map<String, String>?>(
            future: LocalUserRepository().getUser(email),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data != null) {
                final userData = snapshot.data!;
                return ProfilePage(
                    name: userData['name']!, email: userData['email']!);
              } else {
                return Center(child: Text('User not found'));
              }
            },
          );
        },
        '/editProfile': (context) {
          final args =
              ModalRoute.of(context)!.settings.arguments as Map<String, String>;
          return EditProfilePage(name: args['name']!, email: args['email']!);
        },
      },
    );
  }
}
