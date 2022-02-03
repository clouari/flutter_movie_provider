import 'package:flutter/material.dart';
import 'package:flutter_movie_provider/data/movie_api.dart';
import 'package:flutter_movie_provider/ui/home_screen.dart';
import 'package:flutter_movie_provider/ui/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ChangeNotifierProvider<HomeViewModel>(
          create: (_) => HomeViewModel(MovieApi()),
          child: const HomeScreen(),
        ));
  }
}
