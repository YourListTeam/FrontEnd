class Validators {
  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static final RegExp _passwordRegExp = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$',
  );

  static final RegExp _listName = RegExp(
    r'^.{5,}$',
  );

  static final RegExp _colorName = RegExp(
    r'^[a-zA-Z]{3,}$',
  );

  static final RegExp _locationName = RegExp(
    r'^.{3,}$',
  );

  static isValidEmail(String email) {
    return _emailRegExp.hasMatch(email);
  }

  static isValidPassword(String password) {
    return _passwordRegExp.hasMatch(password);
  }

  static isValidListName(String name) {
    return _listName.hasMatch(name);
  }

  static isValidColor(String color) {
    return _colorName.hasMatch(color);
  }

  static isValidLocation(String locName) {
    return _locationName.hasMatch(locName);
  }
}
