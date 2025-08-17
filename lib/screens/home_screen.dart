import 'dart:math';
import 'package:flutter/material.dart';
import '../models/auth_repo.dart';
import '../signup_bloc/signup_bloc.dart';
import 'favorite_screen.dart';
import 'login_screen.dart';
import 'profile_screen.dart';
import 'tip_screen.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "home";
  final String email;

  const HomeScreen({super.key, required this.email});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  String? currentTip;
  List<String> favoriteTips = [];

  final List<String> allTips = [
    'Start your day with a smile.',
    'Practice meditation for 5 minutes daily.',
    'Drink enough water.',
    'Write down 3 things you are grateful for.',
    'Take a break from your phone for one hour daily.',
    'Get 7–8 hours of sleep every night.',
    'Take a short walk to refresh your mind.',
    'Read a few pages from a book you like.',
    'Listen to your favorite music to boost your mood.',
    'Take 3 deep breaths when you feel stressed.',
    'Avoid using your phone before bedtime.',
    'Compliment someone today.',
    'Do one thing you enjoy every day.',
    'Smile at yourself in the mirror.',
  ];

  @override
  void initState() {
    super.initState();
    getRandomTip();
  }

  void getRandomTip() {
    final random = Random();
    setState(() {
      currentTip = allTips[random.nextInt(allTips.length)];
    });
  }

  void addToFavorites(String tip) {
    if (!favoriteTips.contains(tip)) {
      setState(() {
        favoriteTips.add(tip);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      TipsScreen(
        tip: currentTip!,
        onNewTip: getRandomTip,
        onAddFavorite: () => addToFavorites(currentTip!),
      ),
      FavoritesScreen(favorites: favoriteTips),
      ProfileScreen(userName: currentUserName ?? "Guest"),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text(
            "Tips App",
          style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold
          ),
        )),
        backgroundColor: Colors.amber,
      ),
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        backgroundColor: Colors.amber,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.lightbulb),
            label: "Today's Tips",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
