import 'package:flutter/material.dart';
import '../models/auth_repo.dart';
import '../utils/app_colors.dart';
import 'login_screen.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = "profile";
  final String userName;
   const ProfileScreen({super.key,required this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text("Profile Picture",
              style: TextStyle(
            color: AppColors.lightText,
            fontSize: 20,
                fontWeight: FontWeight.bold
        ),
            ),
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://newprofilepic.photo-cdn.net//assets/images/article/profile.jpg?90af0c8",
              ),
            ),
            const SizedBox(height: 40),
            Text(
              userName,
              style: const TextStyle(
                color: AppColors.lightText,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListTile(
                tileColor: AppColors.lightPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                leading: const Icon(Icons.logout, color: Colors.black),
                title: const Text(
                  "Log Out",
                  style: TextStyle(
                    color: AppColors.lightText,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () async {
                  await AuthRepo().logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreenWithBloc(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
