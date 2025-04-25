class AppRegx {
  static bool isEmailValid(String email) {
    final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegExp.hasMatch(email);
  }

  static bool isPasswordValid(String password) {
    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
    final passwordRegExp = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$');
    return passwordRegExp.hasMatch(password);
  }

  static bool isPhoneValid(String phone) {
    // Basic international phone number format
    final phoneRegExp = RegExp(r'^\+?[\d\s-]{10,}$');
    return phoneRegExp.hasMatch(phone);
  }

  static bool isUsernameValid(String username) {
    // 3-20 characters, letters, numbers and underscores only
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]{3,20}$');
    return usernameRegExp.hasMatch(username);
  }

  static bool isNameValid(String name) {
    // Letters, spaces and hyphens only, 2-30 characters
    final nameRegExp = RegExp(r'^[a-zA-Z\s-]{2,30}$');
    return nameRegExp.hasMatch(name);
  }
}