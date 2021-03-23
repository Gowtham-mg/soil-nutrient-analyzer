class ValidationHelper {
  static const String mobileNumberRegex = r'/^(\+\d{1,3}[- ]?)?\d{10}$/';
  // static const String passwordRegex =
  //     r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z])(?=.{8,15})$';
  static const String emailRegex =
      r"/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/g";

  static bool isValidMobile(String mobilenumber) {
    bool _isValid = RegExp(mobileNumberRegex).hasMatch(mobilenumber) &&
        !(RegExp(r'/0{5,}/').hasMatch(mobilenumber));
    return _isValid;
  }

  static String validateEmailAddress(String emailAddress) {
    if (emailAddress.isEmpty) {
      return 'Email Address cannot be empty';
    }
    bool _isValid = RegExp(emailRegex).hasMatch(emailAddress);
    if (_isValid) {
      return 'Not a valid Email Address';
    }
    return null;
  }

  static String validatePhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return 'Phone number cannot be empty';
    } else if (phoneNumber.length != 10) {
      return 'Not a valid phone number';
    }
    return null;
  }

  static String validateCountryCode(String countryCode) {
    if (countryCode.isEmpty) {
      return 'Kindly Select Country...';
    }
    return null;
  }

  static String isValidPassword(String password) {
    if (password.isEmpty) {
      return 'Password cannot be empty';
    }
    bool hasCapitalLetter = RegExp(r'[A-Z]+').hasMatch(password);
    bool hassmallLetter = RegExp(r'[a-z]+').hasMatch(password);
    bool hasNumbers = RegExp(r'[0-9]+').hasMatch(password);
    bool hasSpecialCharacters = RegExp(r'[!@#$&*]').hasMatch(password);
    // Return specific password error
    if (password.length >= 8 && password.length <= 15) {
      if (hasCapitalLetter) {
        if (hassmallLetter) {
          if (hasNumbers) {
            if (hasSpecialCharacters) {
              return null;
            } else {
              return 'Password must contain a special character';
            }
          } else {
            return 'Password must contain a number';
          }
        } else {
          return 'Password must contain a small letter';
        }
      } else {
        return 'Password must contain a capital letter';
      }
    } else {
      return 'Password should contain 8 to 15 characters';
    }
  }
}
