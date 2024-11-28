import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:guess_the_number/src/bloc/bloc.dart';
import 'package:guess_the_number/src/pages/pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
    return BlocProvider(
      create: (_) => GameBloc(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Guess The Number',
        home: HomePage(),
      ),
    );
  }
}
