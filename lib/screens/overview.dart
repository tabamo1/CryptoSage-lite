import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/api.dart';
import '../widgets/cards.dart';
import '../models/models.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
  OverviewData? data;
  bool loading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  Future<void> _load() async {
    setState(() => loading = true);
    final api = Provider.of<ApiService>(context, listen: false);
    final d = await api.fetchOverview();
    setState(() {
      data = d;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading || data == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return RefreshIndicator(
      onRefresh: _load,
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          StatCard(title: "Mode", value: data!.live ? "LIVE" : "PAPER", icon: data!.live ? Icons.play_arrow_rounded : Icons.pause_circle_filled),
          StatCard(title: "Equity", value: "\$${data!.equity.toStringAsFixed(2)}", icon: Icons.account_balance_wallet_outlined),
          StatCard(title: "Open P/L", value: "${data!.openPnlPct.toStringAsFixed(2)}%", icon: Icons.trending_up),
          StatCard(title: "Open Positions", value: "${data!.openPositions}", icon: Icons.stacked_bar_chart),
        ],
      ),
    );
  }
}
