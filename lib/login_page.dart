import 'package:flutter/material.dart';
import 'package:lab2_flutter/local_user_repository.dart'; // Імпортуйте LocalUserRepository

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _userRepository =
      LocalUserRepository(); // Репозиторій для локального сховища
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => _email = value,
                validator: (value) =>
                    !value!.contains('@') ? 'Enter a valid email' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(labelText: 'Password'),
                onChanged: (value) => _password = value,
                validator: (value) => value!.isEmpty ? 'Enter password' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final user = await _userRepository.getUser(_email);
                    if (user != null && user['password'] == _password) {
                      // Передаємо електронну адресу на HomePage
                      Navigator.pushNamed(context, '/home', arguments: _email);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Login failed. Please check your credentials.')),
                      );
                    }
                  }
                },
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
