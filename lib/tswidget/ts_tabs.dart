import 'package:flutter/material.dart';
import 'ts_theme.dart';

class TSTabs extends StatelessWidget {
  final List<Tab> tabs;
  final List<Widget> views;
  const TSTabs({super.key, required this.tabs, required this.views});

  @override
  Widget build(BuildContext context) {
    final config = TSTheme.of(context);
    return DefaultTabController(
      length: tabs.length,
      child: Column(
        children: [
          Material(
            color: config.useGradient ? Colors.transparent : Theme.of(context).colorScheme.primary,
            child: config.useGradient
                ? Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.secondary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: _buildTabBar(context, config),
                  )
                : _buildTabBar(context, config),
          ),
          Expanded(child: TabBarView(children: views)),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, dynamic config) {
    return TabBar(
      tabs: tabs,
      indicatorColor: Theme.of(context).colorScheme.onPrimary,
      labelColor: Theme.of(context).colorScheme.onPrimary,
      labelStyle: TextStyle(
        fontSize: config.fontSize,
        fontWeight: config.fontWeight,
        letterSpacing: config.letterSpacing,
        height: config.lineHeight,
      ),
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7),
      unselectedLabelStyle: TextStyle(
        fontSize: config.fontSize,
        letterSpacing: config.letterSpacing,
        height: config.lineHeight,
      ),
    );
  }
}


