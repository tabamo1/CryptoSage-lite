import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';
import '../models/models.dart';

class PositionsScreen extends StatefulWidget {
  const PositionsScreen({super.key});

  @override
  State<PositionsScreen> createState() => _PositionsScreenState();
}

class _PositionsScreenState extends State<PositionsScreen> {
  List<PositionItem> items = [];
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    final api = Provider.of<ApiService>(context, listen: false);
    final d = await api.fetchPositions();
    setState(() {
      items = d;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading) return const Center(child: CircularProgressIndicator());
    if (items.isEmpty) return const Center(child: Text("No open positions."));
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (c, i) {
          final p = items[i];
          final posColor = p.pnlPct >= 0 ? Colors.green : Colors.red;
          return Card(
            child: ListTile(
              title: Text(p.symbol, style: const TextStyle(fontWeight: FontWeight.w700)),
              subtitle: Text("Qty ${p.qty.toStringAsFixed(4)}  Entry ${p.entry.toStringAsFixed(4)}  Last ${p.last.toStringAsFixed(4)}"),
              trailing: Text("${p.pnlPct.toStringAsFixed(2)}%", style: TextStyle(color: posColor, fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
