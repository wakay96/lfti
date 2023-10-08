import 'package:flutter/material.dart';
import 'package:lfti/constants/enums.dart';
import 'package:lfti/shared/header.dart';

class ProfilePage extends StatelessWidget {
  static final String path = AppPage.profile.path;

  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Header(title: AppPage.profile.title),
          const CircleAvatar(
            radius: 50,
            backgroundImage:
                AssetImage('assets/images/profile_placeholder.png'),
          ),
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
