class CurrencyModel {
  String _key;
  double _value;

  CurrencyModel(
    this._key,
    this._value,
  );

  get key => _key;
  set key(value) => _key = value;

  get value => _value;
  set value(value) => _value = value;
}
