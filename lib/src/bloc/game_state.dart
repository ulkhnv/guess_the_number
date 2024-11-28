import 'package:equatable/equatable.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object> get props => [];
}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final int attemptsLeft;
  final String hint;

  const GameInProgress(this.attemptsLeft, {this.hint = ''});

  @override
  List<Object> get props => [attemptsLeft, hint];
}

class GameWon extends GameState {}

class GameLost extends GameState {
  final int correctNumber;

  const GameLost(this.correctNumber);

  @override
  List<Object> get props => [correctNumber];
}
