import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:search/main_screen.dart';
import 'package:search/ui/linear.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: GoogleFonts.poppins().fontFamily,
      ),
      home: const Home(),
    );
  }
}
