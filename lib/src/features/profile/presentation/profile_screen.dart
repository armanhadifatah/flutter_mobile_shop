import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routing/app_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  static const routeName = '/profile';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          // login button
          TextButton(
              onPressed: () {
                context.goNamed(AppRoute.signIn.name);
              },
              child: const Text('login'))
        ],
      ),
    ));
  }
}
