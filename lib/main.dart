import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme.dart';
import 'router.dart';
import 'services/api.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final backendUrl = await ApiService.loadBackendUrl();
  runApp(MyApp(backendUrl: backendUrl));
}

class MyApp extends StatelessWidget {
  final String backendUrl;
  const MyApp({super.key, required this.backendUrl});

  @override
  Widget build(BuildContext context) {
    return Provider<ApiService>(
      create: (_) => ApiService(baseUrl: backendUrl),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        home: const AppScaffold(),
      ),
    );
  }
}
