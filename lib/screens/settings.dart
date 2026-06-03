import 'package:flutter/material.dart';
import '../services/api.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _backend = TextEditingController();
  bool _saveOk = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final url = await ApiService.loadBackendUrl();
    _backend.text = url;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text("Backend", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        TextField(
          controller: _backend,
          decoration: const InputDecoration(
            labelText: "Backend URL (or 'mock')",
            hintText: "https://your-bot-host.com",
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8),
        FilledButton.icon(
          onPressed: () async {
            await ApiService.saveBackendUrl(_backend.text.trim());
            setState(() {
              _saveOk = true;
            });
          },
          icon: const Icon(Icons.save_alt_rounded),
          label: const Text("Save"),
        ),
        if (_saveOk) const Text("Saved.", style: TextStyle(color: Colors.green)),
      ],
    );
  }
}
