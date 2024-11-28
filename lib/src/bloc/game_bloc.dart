import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  int _number = 0;
  int _attemptsLeft = 0;
  Set<int> history = {};

  GameBloc() : super(GameInitial()) {
    on<StartGameEvent>(_onStart);
    on<GuessNumberEvent>(_onGuess);
    on<RestartGameEvent>(_onRestart);
  }

  void _onStart(StartGameEvent event, Emitter<GameState> emit) {
    _number = Random().nextInt(event.range) + 1;
    _attemptsLeft = event.attempts;

    log("The game has started. Number: $_number. "
        "Attempts left: $_attemptsLeft.");

    emit(GameInProgress(_attemptsLeft));
  }

  void _onGuess(GuessNumberEvent event, Emitter<GameState> emit) {
    if (history.contains(event.guessedNumber)) {
      log("The player re-entered the number: ${event.guessedNumber}");

      emit(GameInProgress(_attemptsLeft, hint: "Вы уже вводили это число"));
      return;
    }

    history.add(event.guessedNumber);
    _attemptsLeft--;
    log(
      "The player entered a number: ${event.guessedNumber}. "
      "Attempts left: $_attemptsLeft.",
    );

    if (event.guessedNumber == _number) {
      log("The player guessed the number: $_number!");

      emit(GameWon());
    } else if (_attemptsLeft > 0) {
      String hint = "Загаданное число "
          "${event.guessedNumber < _number ? 'больше' : 'меньше'} вашего";

      log("The number ${event.guessedNumber} is not guessed. Hint: $hint.");

      emit(GameInProgress(_attemptsLeft, hint: hint));
    } else {
      log("The player lost. The hidden number was: $_number.");

      emit(GameLost(_number));
    }
  }

  void _onRestart(RestartGameEvent event, Emitter<GameState> emit) {
    log("The game has been restarted.");

    history.clear();
    emit(GameInitial());
  }
}
