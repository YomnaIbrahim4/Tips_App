import 'package:flutter/material.dart';

class FavoritesScreen extends StatelessWidget {
  static String routeName = "favorite";
  final List<String> favorites;

  const FavoritesScreen({super.key, required this.favorites});

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text('There are no favorite tips yet.',style: TextStyle(
            color: Colors.black,
            fontSize: 15
        ),),
      );
    }

    return ListView.builder(
      itemCount: favorites.length,
      itemBuilder: (_, index) => ListTile(
        leading: const Icon(Icons.favorite, color: Colors.red),
        title: Text(favorites[index],style:TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),),
      ),
    );
  }
}
