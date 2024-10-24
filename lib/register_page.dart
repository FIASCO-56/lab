import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'user_repository.dart';

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
      final password = prefs.getString('password');
      return {
        'name': name ?? '',
        'email': savedEmail ?? '',
        'password': password ?? '',
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

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _userRepository = LocalUserRepository();
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Реєстрація')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Ім\'я'),
                onChanged: (value) => _name = value,
                validator: (value) =>
                    value!.isEmpty || value.contains(RegExp(r'\d'))
                        ? 'Введіть коректне ім\'я'
                        : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(labelText: 'Електронна пошта'),
                onChanged: (value) => _email = value,
                validator: (value) => !value!.contains('@')
                    ? 'Введіть коректну електронну пошту'
                    : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Пароль'),
                onChanged: (value) => _password = value,
                validator: (value) => value!.length < 6
                    ? 'Пароль має містити не менше 6 символів'
                    : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _userRepository.saveUser(_name, _email, _password);
                    Navigator.pushNamed(context, '/login');
                  }
                },
                child: Text('Зареєструватися'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
