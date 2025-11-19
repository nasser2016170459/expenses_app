enum Currency {
  USD,
  EGP;

  String get symbol {
    switch (this) {
      case Currency.USD:
        return '\$';
      case Currency.EGP:
        return 'EGP';
    }
  }

  String get code => name;
}