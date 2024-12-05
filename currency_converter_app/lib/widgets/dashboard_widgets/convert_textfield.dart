// ignore_for_file: must_be_immutable

import 'package:currency_converter_app/config/color_codes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sizer/flutter_sizer.dart';

class ConvertTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String selectedCurrency;
  final List<String> currencies;
  final void Function(String?)? onCurrencyChanged;
  final String hintText;

  const ConvertTextFieldWidget({
    super.key,
    required this.controller,
    required this.selectedCurrency,
    required this.currencies,
    required this.hintText,
    required this.onCurrencyChanged,
  });

  @override
  State<ConvertTextFieldWidget> createState() => _ConvertTextFieldWidgetState();
}

class _ConvertTextFieldWidgetState extends State<ConvertTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      padding: EdgeInsets.symmetric(
        horizontal: 2.w,
      ),
      decoration: BoxDecoration(
        color: ColorCodes().color5,
        borderRadius: BorderRadius.circular(
          10.dp,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              readOnly: true,
              controller: widget.controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: TextStyle(
                  color: ColorCodes().color3,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 2.w,
          ),
          DropdownButton<String>(
            value: widget.selectedCurrency,
            items: widget.currencies.map((String val) {
              return DropdownMenuItem<String>(
                value: val,
                child: Text(
                  val,
                  style: TextStyle(
                    color: ColorCodes().color3,
                  ),
                ),
              );
            }).toList(),
            onChanged: widget.onCurrencyChanged,
            dropdownColor: ColorCodes().color5,
            underline: const SizedBox(),
            icon: Icon(
              Icons.arrow_drop_down,
              color: ColorCodes().color3,
            ),
          ),
        ],
      ),
    );
  }
}
