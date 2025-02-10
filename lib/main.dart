import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/property_provider.dart';
import './screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => PropertyProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Property Finder',
        theme: ThemeData(
          primarySwatch: Colors.pink,
          scaffoldBackgroundColor: Colors.white,
          fontFamily: 'Cereal', // You'll need to add this font
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
