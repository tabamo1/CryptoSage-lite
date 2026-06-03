import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

class ApiService {
  String baseUrl;
  ApiService({required this.baseUrl});

  static Future<String> loadBackendUrl() async {
    final sp = await SharedPreferences.getInstance();
    return sp.getString('backend_url') ?? 'mock';
  }

  static Future<void> saveBackendUrl(String url) async {
    final sp = await SharedPreferences.getInstance();
    await sp.setString('backend_url', url);
  }

  Future<List<SignalItem>> fetchSignals() async {
    if (baseUrl == 'mock') {
      final mock = [
        {"symbol": "ARBUSDT", "score": 83, "reason": "Partnership rumor + rising RSI", "rsi": 48.2, "emaBull": true, "volumeSpike": 2.1},
        {"symbol": "RNDRUSDT", "score": 78, "reason": "Ecosystem grants; AI sector strength", "rsi": 44.8, "emaBull": true, "volumeSpike": 1.9},
        {"symbol": "TIAUSDT", "score": 74, "reason": "New listing on regional CEX", "rsi": 41.5, "emaBull": false, "volumeSpike": 1.6},
        {"symbol": "PYTHUSDT", "score": 70, "reason": "Roadmap release this week", "rsi": 47.1, "emaBull": true, "volumeSpike": 1.8},
      ];
      return mock.map((e) => SignalItem.fromJson(e)).toList();
    }
    final r = await http.get(Uri.parse('$baseUrl/api/signals'));
    final data = jsonDecode(r.body) as List;
    return data.map((e) => SignalItem.fromJson(e)).toList();
  }

  Future<List<PositionItem>> fetchPositions() async {
    if (baseUrl == 'mock') {
      final mock = [
        {"symbol": "ARBUSDT", "qty": 10, "entry": 1.25, "last": 1.34},
        {"symbol": "TIAUSDT", "qty": 5, "entry": 5.10, "last": 5.02},
      ];
      return mock.map((e) => PositionItem.fromJson(e)).toList();
    }
    final r = await http.get(Uri.parse('$baseUrl/api/positions'));
    final data = jsonDecode(r.body) as List;
    return data.map((e) => PositionItem.fromJson(e)).toList();
  }

  Future<OverviewData> fetchOverview() async {
    if (baseUrl == 'mock') {
      return OverviewData(live: false, equity: 1000.0, openPnlPct: 3.2, openPositions: 2, backend: 'mock');
    }
    final r = await http.get(Uri.parse('$baseUrl/api/overview'));
    final data = jsonDecode(r.body);
    return OverviewData.fromJson(data);
  }

  Future<void> toggleMode(bool live) async {
    if (baseUrl == 'mock') return;
    await http.post(Uri.parse('$baseUrl/api/mode'), body: jsonEncode({"live": live}), headers: {"Content-Type": "application/json"});
  }
}
