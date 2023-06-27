import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:mobile_shop/src/configs/app_images.dart';
import 'package:mobile_shop/src/constants/app_font_size.dart';
import 'package:mobile_shop/src/constants/app_sizes.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';

import '../common_widgets/primary_button.dart';
import '../configs/hive_box.dart';
import 'app_router.dart';

/// Simple not found screen used for 404 errors (page not found on web)
class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Expanded(
            child: SizedBox(),
          ),
          gapH16,
          Row(
            children: [
              Text(
                'Welcome to'.hardcoded,
                style: const TextStyle(fontSize: AppFontSize.headline),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                'Phone Store'.hardcoded,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: AppFontSize.headLine2),
              ),
            ],
          ),
          Image.asset(AppImages.welcome),
          gapH32,
          Text(
            'Lorem ipsum dolor sit amet consectetur. Netus enim feugiat neque adipiscing eget  amet faucibus id.'
                .hardcoded,
            style: const TextStyle(
              fontSize: AppFontSize.title,
            ),
            textAlign: TextAlign.center,
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Expanded(
            child: PrimaryButton(
              onPressed: () => _goTo(context, AppRoute.signIn),
              text: 'Get Started'.hardcoded,
            ),
          ),
          gapH12,
          Row(
            children: [
              Text(
                "Don't want to sign up ?".hardcoded,
                style: const TextStyle(fontSize: AppFontSize.body),
              ),
              const SizedBox(width: 4),
              TextButton(
                  onPressed: () => _goTo(context, AppRoute.home),
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).primaryColor,
                  ),
                  child: Text('Skip'.hardcoded)),
            ],
          ),
          gapH12,
        ],
      ),
    ));
  }

  _goTo(BuildContext context, AppRoute appRoute) async {
    final box = Hive.box(HiveBoxes.app);
    await box.put(HiveBoxes.isWelcomeScreenSeen, true);
    context.goNamed(appRoute.name);
  }
}
