import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';

class GameInProgressWidget extends StatefulWidget {
  final GameInProgress state;

  const GameInProgressWidget(this.state, {super.key});

  @override
  State<GameInProgressWidget> createState() => _GameInProgressWidgetState();
}

class _GameInProgressWidgetState extends State<GameInProgressWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildInputField(),
        const SizedBox(height: 40),
        _buildAttemptsText(),
        const SizedBox(height: 10),
        _buildSubmitButton(context),
      ],
    );
  }

  Widget _buildInputField() {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelText: "Введите ваше число",
        labelStyle: const TextStyle(fontSize: 20, color: Colors.black),
        helperText: widget.state.hint,
        helperStyle: const TextStyle(fontSize: 15),
      ),
      autofocus: true,
      cursorColor: Colors.black,
      style: const TextStyle(fontSize: 50),
      textAlign: TextAlign.center,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
      ],
    );
  }

  Widget _buildAttemptsText() {
    return Text(
      "Осталось попыток: ${widget.state.attemptsLeft}",
      style: const TextStyle(fontSize: 15),
    );
  }

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _submitGuess(context),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
        backgroundColor: Colors.blueAccent,
      ),
      child: const Text(
        "Подтвердить",
        style: TextStyle(color: Colors.white, fontSize: 15),
      ),
    );
  }

  void _submitGuess(BuildContext context) {
    final inputText = _textEditingController.text;
    if (inputText.isNotEmpty) {
      context.read<GameBloc>().add(GuessNumberEvent(int.parse(inputText)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите число перед подтверждением!')),
      );
    }
  }
}
