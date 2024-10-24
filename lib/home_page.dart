import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final String email;

  const HomePage({Key? key, required this.email}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String name; // Додайте змінну для збереження імені
  List<String> tireList = [
    'Summer Tires',
    'Winter Tires',
    'All-Season Tires',
    'Performance Tires',
  ];

  @override
  void initState() {
    super.initState();
    // Тут ви можете отримати ім'я з локального сховища або задати його за замовчуванням
    name = "User"; // Задайте значення за замовчуванням
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Обробка натискання кнопки кошика
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Home Page, $name!',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: tireList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(tireList[index]),
                    trailing: ElevatedButton(
                      onPressed: () {
                        // Обробка натискання на кнопку "Закупити"
                        Navigator.pushNamed(
                          context,
                          '/purchase',
                          arguments: tireList[index],
                        );
                      },
                      child: Text('Purchase'),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/profile',
                    arguments: widget.email);
              },
              child: Text('View Profile'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.pushNamed(
                  context,
                  '/editProfile',
                  arguments: {'name': name, 'email': widget.email},
                );

                // Обробка результату після редагування
                if (result != null) {
                  final updatedData = result as Map<String, String>;
                  setState(() {
                    name = updatedData['name']!;
                  });
                }
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
