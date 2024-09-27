import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Color & Position Randomizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0; // Лічильник
  String _message = "Enter something!";
  final TextEditingController _controller = TextEditingController();
  Color _currentColor = Colors.blue; // Початковий колір фону
  final Random _random = Random(); // Для генерації випадкових чисел

  // Функція для оновлення лічильника
  void _updateCounter() {
    setState(() {
      String input = _controller.text;

      // Логіка для тексту "ZELENSKY" та чисел
      if (input.toUpperCase() == "ZELENSKY") {
        _counter = 0; // Анулюємо лічильник
        _message = "Counter reset by ZELENSKY!";
      } else if (int.tryParse(input) != null) {
        _counter += int.parse(input); // Додаємо введене число
        _message = "Added: $input";
      } else {
        _message = "Not a number! Try again!";
      }

      // Зміна кольору фону випадковим чином
      _currentColor = Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      );
    });
  }

  // Функція для отримання випадкової позиції для кнопки
  Offset _getRandomPosition() {
    double x = _random.nextDouble() * 0.8; // 80% ширини екрану
    double y = _random.nextDouble() * 0.8; // 80% висоти екрану
    return Offset(x, y);
  }

  @override
  Widget build(BuildContext context) {
    Offset buttonPosition =
        _getRandomPosition(); // Отримання нової позиції кнопки

    return Scaffold(
      body: Container(
        color: _currentColor, // Фон змінюється випадковим чином
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Counter: $_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: 10),
              Text(
                _message,
                style: TextStyle(fontSize: 20, color: Colors.grey.shade800),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter a number or "ZELENSKY"',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 20),
              // Кнопка з випадковою позицією
              Positioned(
                left: buttonPosition.dx * MediaQuery.of(context).size.width,
                top: buttonPosition.dy * MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: () {
                    _updateCounter();
                    setState(() {}); // Переміщуємо кнопку
                  },
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
