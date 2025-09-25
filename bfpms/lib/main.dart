import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // ✅ Required for Riverpod
import 'package:provider/provider.dart'; // ✅ Required for AdminProvider

import 'pages/splash_screen/splash_screen.dart';
import 'providers/admin_provider.dart';

void main() {
  runApp(
    ProviderScope(
      // ✅ This is required for Riverpod to work
      child: ChangeNotifierProvider(
        create: (_) => AdminProvider(), // ✅ Your old provider still works
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
