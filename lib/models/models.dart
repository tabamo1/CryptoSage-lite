class SignalItem {
  final String symbol;
  final double score;
  final String reason;
  final double rsi;
  final bool emaBull;
  final double volumeSpike;

  SignalItem({required this.symbol, required this.score, required this.reason, required this.rsi, required this.emaBull, required this.volumeSpike});

  factory SignalItem.fromJson(Map<String, dynamic> j) => SignalItem(
        symbol: j['symbol'],
        score: (j['score'] as num).toDouble(),
        reason: j['reason'] ?? '',
        rsi: (j['rsi'] as num?)?.toDouble() ?? 50.0,
        emaBull: j['emaBull'] ?? false,
        volumeSpike: (j['volumeSpike'] as num?)?.toDouble() ?? 1.0,
      );
}

class PositionItem {
  final String symbol;
  final double qty;
  final double entry;
  final double last;
  final double pnlPct;

  PositionItem({required this.symbol, required this.qty, required this.entry, required this.last}) : pnlPct = ((last - entry) / entry) * 100.0;

  factory PositionItem.fromJson(Map<String, dynamic> j) => PositionItem(
        symbol: j['symbol'],
        qty: (j['qty'] as num).toDouble(),
        entry: (j['entry'] as num).toDouble(),
        last: (j['last'] as num).toDouble(),
      );
}

class OverviewData {
  final bool live;
  final double equity;
  final double openPnlPct;
  final int openPositions;
  final String backend;

  OverviewData({required this.live, required this.equity, required this.openPnlPct, required this.openPositions, required this.backend});

  factory OverviewData.fromJson(Map<String, dynamic> j) => OverviewData(
        live: j['live'] ?? false,
        equity: (j['equity'] as num).toDouble(),
        openPnlPct: (j['openPnlPct'] as num).toDouble(),
        openPositions: j['openPositions'] ?? 0,
        backend: j['backend'] ?? 'mock',
      );
}
