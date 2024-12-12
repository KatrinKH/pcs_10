import 'package:flutter/material.dart';
import 'package:pcs_10/presentation/screens/notes_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  // superbase setup
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://qdxyqjcvgidknhysppme.supabase.co",
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFkeHlxamN2Z2lka25oeXNwcG1lIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5ODM4NDksImV4cCI6MjA0OTU1OTg0OX0.LNWgAfkJYlIqWDgE9psEDKO_aWuLEmaAyr8wywTI9Og",
  );

  // run app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Games App 米可-06',
      home: NotesPage(),
      );
  }
}

