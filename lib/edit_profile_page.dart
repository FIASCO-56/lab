import 'package:flutter/material.dart';
import 'local_user_repository.dart'; // Не забудьте імпортувати репозиторій

class EditProfilePage extends StatefulWidget {
  final String name;
  final String email;

  EditProfilePage({required this.name, required this.email});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _userRepository = LocalUserRepository();
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late String _email;

  @override
  void initState() {
    super.initState();
    _name = widget.name;
    _email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Повертає на попередню сторінку
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) => _name = value,
                validator: (value) => value!.isEmpty || value.contains(RegExp(r'\d')) ? 'Enter a valid name' : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) => _email = value,
                validator: (value) => !value!.contains('@') ? 'Enter a valid email' : null,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _userRepository.saveUser(_name, _email, ''); // Оновіть збереження
                    Navigator.pop(context, {'name': _name, 'email': _email}); // Повертає оновлені дані назад
                  }
                },
                child: Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
