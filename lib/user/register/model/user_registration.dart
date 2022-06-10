class UserRegistration {
  String? name;
  String? email;
  bool isAdmin = false;
  String? newPassword;
  String? newPasswordConfirmation;

  UserRegistration();

  bool isFieldsValid() {
    return isNameValid() && isEmailValid() && isNewPasswordValid();
  }

  bool isNameValid() {
    return name != null && name!.trim().isNotEmpty;
  }

  bool isEmailValid() {
    return email != null && email!.trim().isNotEmpty;
  }

  bool isNewPasswordValid() {
    return (newPassword != null && newPasswordConfirmation != null) &&
        newPassword == newPasswordConfirmation;
  }

  bool bothPasswordFieldsEmpty() {
    return ((newPassword == null || newPassword!.isEmpty)
        && (newPasswordConfirmation == null || newPasswordConfirmation!.isEmpty));
  }
}
