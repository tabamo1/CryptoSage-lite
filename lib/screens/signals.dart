import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';
import '../models/models.dart';

class SignalsScreen extends StatefulWidget {
  const SignalsScreen({super.key});

  @override
  State<SignalsScreen> createState() => _SignalsScreenState();
}

class _SignalsScreenState extends State<SignalsScreen> {
  List<SignalItem> items = [];
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    final api = Provider.of<ApiService>(context, listen: false);
    final d = await api.fetchSignals();
    setState(() {
      items = d;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (c, i) {
          final s = items[i];
          return Card(
            child: ListTile(
              title: Text(s.symbol, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text(s.reason),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("Score ${s.score.toStringAsFixed(0)}"),
                  Text("RSI ${s.rsi.toStringAsFixed(1)}  Volx${s.volumeSpike.toStringAsFixed(1)}", style: const TextStyle(fontSize: 12)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
