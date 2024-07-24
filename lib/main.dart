import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_intro/pages/home_page.dart';
import 'package:getx_intro/widgets/utils.dart';
import 'package:google_fonts/google_fonts.dart';

void main(List<String> args) async {
  await registerServices();
  await registerControllers();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme()),
      debugShowCheckedModeBanner: false,
      routes: {'/home': (context) => HomePage()},
      initialRoute: '/home',
    );
  }
}
