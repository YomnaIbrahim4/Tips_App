import 'package:flutter/material.dart';

import '../widgets/custom_button.dart';

class TipsScreen extends StatelessWidget {
  static String routeName = "tips";
  final String tip;
  final VoidCallback onNewTip;
  final VoidCallback onAddFavorite;

  const TipsScreen({
    super.key,
    required this.tip,
    required this.onNewTip,
    required this.onAddFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              tip,
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            CustomButton(
              text: "Add to favorite",
              icon: Icons.favorite_border,
              onPressed: onAddFavorite,
            ),
            TextButton(
              onPressed: onNewTip,
              child: const Text('A new tip',style: TextStyle(
                  color: Colors.black,
                  fontSize: 15
              ),),
            ),
          ],
        ),
      ),
    );
  }
}
