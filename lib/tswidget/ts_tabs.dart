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
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool tooSmall = constraints.maxHeight < 200;
          final Widget tabBarMaterial = Material(
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
          );
          if (tooSmall) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  tabBarMaterial,
                  SizedBox(height: 400, child: TabBarView(children: views)),
                ],
              ),
            );
          }
          return Column(
            children: [
              tabBarMaterial,
              Expanded(child: TabBarView(children: views)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildTabBar(BuildContext context, dynamic config) {
    return TabBar(
      tabs: tabs,
      indicatorColor: Theme.of(context).colorScheme.onPrimary,
      labelColor: Theme.of(context).colorScheme.onPrimary,
      labelStyle: tsTextStyleForConfig(
        config,
        size: config.fontSize,
        weight: config.fontWeight,
      ),
      unselectedLabelColor: Theme.of(context).colorScheme.onPrimary.withValues(alpha: 0.7),
      unselectedLabelStyle: tsTextStyleForConfig(
        config,
        size: config.fontSize,
      ),
    );
  }
}


