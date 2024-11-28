import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';

class DefeatDialog extends StatelessWidget {
  final int correctNumber;

  const DefeatDialog({super.key, required this.correctNumber});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        "Вы проиграли",
        style: TextStyle(color: Colors.white),
      ),
      content: Text(
        "Загаданное число: $correctNumber",
        style: const TextStyle(color: Colors.white),
      ),
      actions: [
        TextButton(
            onPressed: () {
              context.read<GameBloc>().add(RestartGameEvent());
              Navigator.of(context).pop();
            },
            child: const Text(
              "Начать заново",
              style: TextStyle(color: Colors.white),
            ))
      ],
      backgroundColor: Colors.red,
    );
  }
}
