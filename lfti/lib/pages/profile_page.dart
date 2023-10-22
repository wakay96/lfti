import 'package:flutter/material.dart';

import 'package:lfti/shared/header.dart';

class ProfilePage extends StatelessWidget {
  static const String path = '/profile';

  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Header(title: 'Profile'),
          // const CircleAvatar(
          //   radius: 50,
          // ),
          const Icon(Icons.person_outline, size: 100),
          const SizedBox(height: 16),
          Text(
            'Username',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'user@example.com',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
