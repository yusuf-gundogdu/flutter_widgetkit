import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final List<NavigationDestination> destinations;

  const TSNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    required this.destinations,
  });

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,
      backgroundColor: Theme.of(context).colorScheme.surface,
      indicatorColor: config.primaryColor.withValues(alpha: 0.12),
      elevation: config.elevation,
      destinations: destinations,
    );
  }
}


