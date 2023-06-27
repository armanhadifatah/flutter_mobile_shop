// Stateful nested navigation based on:
// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_shop/src/configs/app_icon.dart';
import 'package:mobile_shop/src/localization/string_hardcoded.dart';

class ScaffoldWithNestedNavigation extends StatefulWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  @override
  State<ScaffoldWithNestedNavigation> createState() =>
      _ScaffoldWithNestedNavigationState();
}

class _ScaffoldWithNestedNavigationState
    extends State<ScaffoldWithNestedNavigation> {
  void _goBranch(int index) {
    widget.navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: widget.navigationShell.currentIndex,
        destinations: [
          NavigationDestination(
              label: 'Products'.hardcoded,
              selectedIcon: SvgPicture.asset(
                AppIcon.home,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              icon: SvgPicture.asset(
                AppIcon.home,
              )),
          NavigationDestination(
              label: 'Favorite'.hardcoded,
              selectedIcon: SvgPicture.asset(
                AppIcon.favorite,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              icon: SvgPicture.asset(
                AppIcon.favorite,
              )),
          NavigationDestination(
              label: 'Categories'.hardcoded,
              selectedIcon: SvgPicture.asset(
                AppIcon.category,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              icon: SvgPicture.asset(
                AppIcon.category,
              )),
          NavigationDestination(
              label: 'Profile'.hardcoded,
              selectedIcon: SvgPicture.asset(
                AppIcon.profile,
                colorFilter: ColorFilter.mode(
                    Theme.of(context).primaryColor, BlendMode.srcIn),
              ),
              icon: SvgPicture.asset(
                AppIcon.profile,
              )),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
