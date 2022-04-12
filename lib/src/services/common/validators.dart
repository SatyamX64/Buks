// ignore_for_file: body_might_complete_normally_nullable

class Validate {
  static bool password(String value) {
    // Minimum eight characters, at least one letter and one number:
    bool isValid =
        RegExp(r"^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$").hasMatch(value);
    return isValid;
  }

  static bool email(String value) {
    bool isValid = RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
    return isValid;
  }
}
