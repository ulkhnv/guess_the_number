import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';

class GameInitialWidget extends StatefulWidget {
  const GameInitialWidget({super.key});

  @override
  GameInitialWidgetState createState() => GameInitialWidgetState();
}

class GameInitialWidgetState extends State<GameInitialWidget> {
  int range = 100;
  int attempts = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRangeSlider(),
        const SizedBox(height: 16),
        _buildAttemptsSlider(),
        const Spacer(),
        _buildStartButton(context),
      ],
    );
  }

  Widget _buildRangeSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Диапазон чисел: 1-$range',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('1'),
            Expanded(
              child: Slider(
                activeColor: Colors.blueAccent,
                value: range.toDouble(),
                min: 10,
                max: 1000,
                divisions: 99,
                label: range.toString(),
                onChanged: (value) {
                  setState(() {
                    range = value.toInt();
                  });
                },
              ),
            ),
            const Text("1000"),
          ],
        ),
      ],
    );
  }

  Widget _buildAttemptsSlider() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Количество попыток: $attempts',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            const Text('1'),
            Expanded(
              child: Slider(
                activeColor: Colors.blueAccent,
                value: attempts.toDouble(),
                min: 1,
                max: 10,
                label: attempts.toString(),
                onChanged: (value) {
                  setState(() {
                    attempts = value.toInt();
                  });
                },
              ),
            ),
            const Text("10"),
          ],
        ),
      ],
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          context.read<GameBloc>().add(StartGameEvent(range, attempts));
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 120, vertical: 10),
          backgroundColor: Colors.blueAccent,
        ),
        child: const Text(
          'Начать',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
