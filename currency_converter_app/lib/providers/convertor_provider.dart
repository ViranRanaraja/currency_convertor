import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config/config.dart';
import '../models/currency_model.dart';

class CurrencyConvertorProvider extends ChangeNotifier {
  String convertion_result = "";
  List<CurrencyModel> _currencies = [];
  List<String> _currencyList = [];

  List<String> get getCurrencyList => _currencyList;

  set setCurrencyList(List<String> value) {
    _currencyList = value;
    notifyListeners();
  }

  Future<void> getListCurrencies(String baseCode) async {
    final url = Uri.parse('${Configs.currenciesBaseURL}/latest/$baseCode');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json',
        },
      );

      final extractedData = json.decode(response.body);

      if (extractedData == null || extractedData['conversion_rates'] == null) {
        return;
      }

      final conversionRates =
          extractedData['conversion_rates'] as Map<String, dynamic>;
      final List<CurrencyModel> tempCurrencies = [];

      conversionRates.forEach((key, value) {
        tempCurrencies.add(
          CurrencyModel(
            key,
            value is int ? value.toDouble() : value,
          ),
        );
        _currencyList.add(key);
      });
      _currencies = tempCurrencies;
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> getConvertedAmount(
      String baseCode, String convertCode, double amount) async {
    final url = Uri.parse(
        '${Configs.currenciesBaseURL}/pair/$baseCode/$convertCode/$amount');
    try {
      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          'Accept': 'application/json'
        },
      );
      final extractedData = json.decode(response.body);

      if (extractedData == null) {
        return;
      }

      if (response.statusCode == 200) {
        final extractedData = json.decode(response.body);
        convertion_result = extractedData['conversion_result'].toString();
      } else {
        throw Exception('Failed to Get Result.');
      }
      notifyListeners();
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
