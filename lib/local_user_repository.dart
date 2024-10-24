import 'package:shared_preferences/shared_preferences.dart';
import 'user_repository.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LocalUserRepository implements UserRepository {
  @override
  Future<void> saveUser(String name, String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('password', hashPassword(password));
  }

  @override
  Future<Map<String, String>?> getUser(String email) async {
    final prefs = await SharedPreferences.getInstance();
    final storedEmail = prefs.getString('email');
    if (storedEmail == email) {
      return {
        'name': prefs.getString('name') ?? '',
        'email': storedEmail ?? '',
        'password': prefs.getString('password') ?? '',
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

  String hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }
}
