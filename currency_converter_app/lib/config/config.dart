import 'package:flutter_dotenv/flutter_dotenv.dart';

class Configs {
  static String currenciesBaseURL =
      "https://v6.exchangerate-api.com/v6/${dotenv.env['COUNTRIES_API']}";
  // static String restCountriesBaseURL = "https://restcountries.com/v3.1";
}
