import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  final String name;
  final String email;

  ProfilePage({required this.name, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, {'name': name, 'email': email});
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: $name',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(
              'Email: $email',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/editProfile',
                  arguments: {'name': name, 'email': email},
                );
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Перехід на головну сторінку
                Navigator.popUntil(context, ModalRoute.withName('/home'));
              },
              child: Text('Go to Home'),
            ),
          ],
        ),
      ),
    );
  }
}
