import 'package:currency_converter_app/config/color_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:provider/provider.dart';

import '../providers/convertor_provider.dart';
import '../widgets/dashboard_widgets/button.dart';
import '../widgets/dashboard_widgets/convert_textfield.dart';
import '../widgets/dashboard_widgets/textfield.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  static const routeName = "/dashboard-screen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _insertController = TextEditingController();
  final List<TextEditingController> _controllers = [];
  final List<String> _selectedCurrencies = [];
  final List<String> _convertedValues = [];
  String selected = "USD";
  String selectedConvert = "USD";
  String baseCode = "USD";
  int converterCount = 0;

  @override
  void initState() {
    Provider.of<CurrencyConvertorProvider>(context, listen: false)
        .getListCurrencies("USD");
    _insertController.addListener(_onTextChanged);
    super.initState();
  }

  void _onTextChanged() {
    double baseAmount = double.tryParse(_insertController.text) ?? 0.0;

    setState(() {
      for (int i = 0; i < _controllers.length; i++) {
        Provider.of<CurrencyConvertorProvider>(context, listen: false)
            .getConvertedAmount(
          baseCode,
          _selectedCurrencies[i],
          baseAmount,
        );
        _convertedValues[i] =
            Provider.of<CurrencyConvertorProvider>(context, listen: false)
                .convertion_result;
        _controllers[i].text = _convertedValues[i];
      }
    });
  }

  @override
  void dispose() {
    _insertController.dispose();
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CurrencyConvertorProvider>(
      builder: (context, currencies, child) => Scaffold(
        backgroundColor: ColorCodes().color2,
        appBar: AppBar(
          backgroundColor: ColorCodes().color2,
          title: Padding(
            padding: EdgeInsets.fromLTRB(15.w, 0, 0, 0),
            child: Text(
              'Advanced Exchanger',
              style: TextStyle(
                color: ColorCodes().color3,
                fontSize: 16.dp,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: ColorCodes().color3,
            ),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: SizedBox(
              width: double.infinity,
              height: 90.h,
              child: Column(
                children: [
                  SizedBox(
                    height: 4.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      "INSERT AMOUNT:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorCodes().color5,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextFieldWidget(
                    controller: _insertController,
                    selectedCurrency: selected,
                    currencies: currencies.getCurrencyList,
                    hintText: "",
                    onCurrencyChanged: (newVal) {
                      setState(() {
                        selected = newVal!;
                        baseCode = newVal;
                        currencies.getConvertedAmount(
                          baseCode,
                          selectedConvert,
                          double.parse(
                            _insertController.text,
                          ),
                        );
                      });
                    },
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  SizedBox(
                    width: 90.w,
                    child: Text(
                      "CONVERT TO:",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: ColorCodes().color5,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  SizedBox(
                    height: 50.h,
                    width: 90.w,
                    child: ListView.builder(
                      itemCount: _controllers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 2.h),
                          child: ConvertTextFieldWidget(
                            controller: _controllers[index],
                            selectedCurrency: _selectedCurrencies[index],
                            currencies: currencies.getCurrencyList,
                            hintText: _convertedValues[index] != ""
                                ? _convertedValues[index]
                                : "",
                            onCurrencyChanged: (newVal) {
                              setState(() {
                                _selectedCurrencies[index] = newVal!;

                                currencies.getConvertedAmount(
                                  baseCode,
                                  _selectedCurrencies[index],
                                  double.parse(
                                    _insertController.text,
                                  ),
                                );
                                _convertedValues[index] =
                                    currencies.convertion_result;
                              });
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  CustomButtonWidget(
                    buttonColor: ColorCodes().color4,
                    onPressed: () {
                      setState(() {
                        _controllers.add(
                          TextEditingController(),
                        );
                        _selectedCurrencies.add("USD");
                        _convertedValues.add("0.0");
                      });
                    },
                    text: '+ Add Convertor',
                    textColor: ColorCodes().color3,
                    width: 50.w,
                    height: 5.h,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
