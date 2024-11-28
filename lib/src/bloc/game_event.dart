import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class StartGameEvent extends GameEvent {
  final int range;
  final int attempts;

  const StartGameEvent(this.range, this.attempts);

  @override
  List<Object> get props => [range, attempts];
}

class GuessNumberEvent extends GameEvent {
  final int guessedNumber;

  const GuessNumberEvent(this.guessedNumber);

  @override
  List<Object> get props => [guessedNumber];
}

class RestartGameEvent extends GameEvent {}
