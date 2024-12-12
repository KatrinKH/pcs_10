import 'package:flutter/material.dart';
import 'package:pcs_10/presentation/screens/home_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:pcs_10/presentation/screens/favorites_page.dart';
import 'package:pcs_10/presentation/screens/profile_page.dart';

void main() async {
  // Supabase setup
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 126, 96, 178)),
        useMaterial3: true,
      ),
      home: const MainMenu(),
    );
  }
}

class MainMenu extends StatefulWidget {
  const MainMenu({super.key});

  @override
  State<MainMenu> createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  int _selectedIndex = 0;

  // Метод для обновления выбранного элемента меню
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Определяем, какие экраны отображать для каждого пункта меню
  List<Widget> _widgetOptions(BuildContext context) {
    return [
      const HomePage(), // Главная страница
      const FavoritesPage(), // Страница избранного
      const ProfilePage(), // Страница профиля
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions(context).elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromARGB(255, 32, 100, 156),
        onTap: _onItemTapped,
      ),
    );
  }
}
