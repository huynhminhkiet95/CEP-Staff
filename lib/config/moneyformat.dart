class MoneyFormat {
  static const String dateTimeSearch = "yyyyMMdd";

  static String moneyFormat(String price) {
    var value = price;
    value = value.replaceAll(RegExp(r'\D'), '');
    value = value.replaceAll(RegExp(r'\B(?=(\d{3})+(?!\d))'), ',');
    return value;
  }

  static int convertCurrencyToInt(String value) {
    if (value.isEmpty || value == null) {
      return 0;
    }
    return int.parse(value.replaceAll(',', ''));
  }
}
