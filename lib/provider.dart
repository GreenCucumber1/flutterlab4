import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'models/query_data/query_data.dart';
import 'models/weather/weather.dart';

class InputProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  WeatherHTTP? _qwer;
  WeatherHTTP? get qwer => _qwer;

  final List<QueryData> _queriesHistory = [];
  List<QueryData> get queriesHistory => _queriesHistory;

  Future<void> fetchStatusCode(String x, String y) async {
    _isLoading = true;
    notifyListeners();
    var x1 = num.parse(x).toDouble();
    var y1 = num.parse(y).toDouble();
    String qwer =
        "https://api.weatherbit.io/v2.0/forecast/daily?lat=${x1}1&lon=${y1}1&key=5e2805de11cd4b7baad01f51ed9c7a23&include=minutely";
    final response = await http.get(Uri.parse(qwer));
    if (response.statusCode == 200) {
      _qwer = WeatherHTTP.fromJson(jsonDecode(response.body));
      saveToDatabase();
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> saveToDatabase() async {
    _isLoading = true;
    notifyListeners();
    var box = await Hive.openBox<QueryData>('QueryData');
    box.add(
      QueryData(
        city: _qwer?.city_name ?? "-",
        queryExecuteDateTime: DateTime.now(),
      ),
    );
    _isLoading = false;
    notifyListeners();
  }

  Future<void> readDatabase() async {
    queriesHistory.clear();
    _isLoading = true;
    notifyListeners();
    final box = await Hive.openBox<QueryData>('QueryData');
    queriesHistory.addAll(box.values.toList());
    _isLoading = false;
    notifyListeners();
  }
}
