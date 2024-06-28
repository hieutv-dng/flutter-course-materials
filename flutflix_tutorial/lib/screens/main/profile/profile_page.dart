import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profile Screen'),
            TextButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                FirebaseAuth.instance.currentUser?.uid;
              },
              child: const Text('Sign Out'),
            ),
          ],
        ),
      ),
    );
  }
}
