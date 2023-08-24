import 'package:beyourpt/Screens/exercises_page.dart';
import 'package:beyourpt/Screens/programs_page.dart';
import 'package:beyourpt/services/databases/programs_database.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart';

import '../bloc/exercise/exercise_bloc.dart';
import '../bloc/programs/programs_bloc.dart';

final client = Client();
final programBloc = ProgramsBloc(ProgramsDatabase());
final boxNameBloc = BoxNamesBloc(ProgramsDatabase());
final exerciseBloc = ExerciseBloc();

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    // Home Page
    const ExercisesPage(),

    // Programs Page
    const ProgramsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [Colors.white, Colors.green],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: _pages[_selectedIndex],
          bottomNavigationBar:
              BottomNavBar(onTabChange: (index) => navigateBottomBar(index)),
        ),
    );
  }
}

class BottomNavBar extends StatefulWidget {
  void Function(int)? onTabChange;
  BottomNavBar({super.key, required this.onTabChange});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: GNav(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        color: Colors.grey[900],
        activeColor: Colors.grey[900],
        tabBackgroundColor: Colors.grey.shade800,
        tabBorderRadius: 16,
        onTabChange: (value) => widget.onTabChange!(value),
        tabs: const [
          GButton(
            icon: Icons.home_filled,
            text: 'Home',
            iconSize: 30,
            textColor: Colors.white,
            iconColor: Colors.black,
            iconActiveColor: Colors.green,
          ),
          GButton(
            icon: Icons.fitness_center_outlined,
            text: 'Programs',
            iconSize: 30,
            textColor: Colors.white,
            iconColor: Colors.black,
            iconActiveColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
