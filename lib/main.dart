import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_themoviedb/core/widget/simple_bloc_observer.dart';
import 'package:test_themoviedb/features/trending/presentation/page/trending_page.dart';
import 'core/di/injection_container.dart' as di;

void main() async {
  await di.init();
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TredingPage(),
    );
  }
}
