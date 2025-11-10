extension StringValidators on String {
  // Name: Only letters, at least 2 characters
  bool get isValidName {
    final nameRegExp = RegExp(r"^[A-Za-z\s]{2,}$");
    return nameRegExp.hasMatch(this.trim());
  }

  // Email: Basic email pattern
  bool get isValidEmail {
    final emailRegExp = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    return emailRegExp.hasMatch(this.trim());
  }

  // Message: Not empty, at least 5 characters
  bool get isValidMessage {
    return this.trim().length >= 5;
  }
}
