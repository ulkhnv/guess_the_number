import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';
import 'package:guess_the_number/src/widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: BlocConsumer<GameBloc, GameState>(
            builder: (context, state) {
              if (state is GameInitial) {
                return const GameInitialWidget();
              } else if (state is GameInProgress) {
                return GameInProgressWidget(state);
              } else {
                return Container();
              }
            },
            listener: (context, state) {
              if (state is GameWon) {
                showDialog(
                  context: context,
                  builder: (_) => const VictoryDialog(),
                  barrierDismissible: false,
                );
              } else if (state is GameLost) {
                showDialog(
                  context: context,
                  builder: (_) =>
                      DefeatDialog(correctNumber: state.correctNumber),
                  barrierDismissible: false,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
