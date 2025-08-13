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
            color: config.primaryColor,
            child: TabBar(
              tabs: tabs,
              indicatorColor: Colors.white,
              labelColor: Colors.white,
              labelStyle: TextStyle(
                fontSize: config.fontSize,
                fontWeight: config.fontWeight,
                letterSpacing: config.letterSpacing,
                height: config.lineHeight,
              ),
              unselectedLabelColor: Colors.white.withValues(alpha: 0.7),
              unselectedLabelStyle: TextStyle(
                fontSize: config.fontSize,
                letterSpacing: config.letterSpacing,
                height: config.lineHeight,
              ),
            ),
          ),
          Expanded(child: TabBarView(children: views)),
        ],
      ),
    );
  }
}


