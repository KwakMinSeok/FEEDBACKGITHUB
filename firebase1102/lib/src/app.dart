import 'package:firebase1102/src/providers/entry_provider.dart';
import 'package:firebase1102/src/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> EntryProvider(),
          child: MaterialApp(
        home: HomeScreen()
      ),
    );
  }
}