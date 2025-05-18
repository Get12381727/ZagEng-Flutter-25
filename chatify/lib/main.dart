import 'package:chatify/Signup.dart';
import 'package:chatify/Home.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jnctkajqvjibfvwwnjix.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImpuY3RrYWpxdmppYmZ2d3duaml4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDc0ODQyMjksImV4cCI6MjA2MzA2MDIyOX0.5Q7XbqnWdhrMfvIXLlKnTp6JWf-0YD1PZCxrFB1Uc3k',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chatify',
      theme: ThemeData.dark(useMaterial3: true),
      home: const Login(),
    );
  }
}
