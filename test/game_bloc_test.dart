import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';

void main() {
  group('GameBloc', () {
    late GameBloc gameBloc;

    setUp(() {
      gameBloc = GameBloc();
    });

    tearDown(() {
      gameBloc.close();
    });

    test('Initial state is GameInitial', () {
      expect(gameBloc.state, equals(GameInitial()));
    });

    blocTest<GameBloc, GameState>(
      'Emits [GameInProgress] when StartGameEvent is added',
      build: () => gameBloc,
      act: (bloc) => bloc.add(const StartGameEvent(100, 5)),
      verify: (bloc) {
        expect((bloc.state as GameInProgress).attemptsLeft, equals(5));
      },
    );

    blocTest<GameBloc, GameState>(
      'Emits GameWon when guessed number is correct',
      build: () {
        final bloc = GameBloc();
        bloc.add(const StartGameEvent(1, 1));
        return bloc;
      },
      act: (bloc) {
        bloc.add(const GuessNumberEvent(1));
      },
      expect: () => [
        isA<GameInProgress>(),
        isA<GameWon>(),
      ],
    );

    blocTest<GameBloc, GameState>(
      'Emits GameLost when attempts are exhausted',
      build: () {
        final bloc = GameBloc();
        bloc.add(const StartGameEvent(100, 1));
        return bloc;
      },
      act: (bloc) {
        bloc.add(const GuessNumberEvent(999));
      },
      expect: () => [
        isA<GameInProgress>(),
        isA<GameLost>(),
      ],
    );
  });
}
