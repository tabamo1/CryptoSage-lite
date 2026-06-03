import 'package:flutter/material.dart';
import 'screens/overview.dart';
import 'screens/signals.dart';
import 'screens/positions.dart';
import 'screens/settings.dart';

class AppScaffold extends StatefulWidget {
  const AppScaffold({super.key});

  @override
  State<AppScaffold> createState() => _AppScaffoldState();
}

class _AppScaffoldState extends State<AppScaffold> {
  int _idx = 0;

  final _pages = const [
    OverviewScreen(),
    SignalsScreen(),
    PositionsScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("CryptoSage AI (Lite)")),
      body: _pages[_idx],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _idx,
        onDestinationSelected: (i) => setState(() => _idx = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_customize_outlined), label: 'Overview'),
          NavigationDestination(icon: Icon(Icons.bolt_outlined), label: 'Signals'),
          NavigationDestination(icon: Icon(Icons.stacked_line_chart_outlined), label: 'Positions'),
          NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}
