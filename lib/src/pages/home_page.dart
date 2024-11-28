import 'package:flutter/material.dart';
import 'package:guess_the_number/src/pages/pages.dart';
import 'package:guess_the_number/src/widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Spacer(flex: 2),
          const BlinkingTextWidget(text: 'Guess The Number'),
          const Spacer(),
          _buildNewGameButton(context),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildNewGameButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const GamePage()),
        );
      },
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          backgroundColor: Colors.blueAccent),
      child: const Text(
        'Новая игра',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
