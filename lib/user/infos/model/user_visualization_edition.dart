class UserVisualizationEdition {
  int id;
  String name;
  String email;
  bool isAdmin;
  String? newPassword;
  String? newPasswordConfirmation;

  UserVisualizationEdition({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    this.newPassword,
    this.newPasswordConfirmation,
  });

  bool isFieldsValid() {
    return isNameValid() && isEmailValid() && isNewPasswordValid();
  }

  bool isNameValid() {
    return name.trim().isNotEmpty;
  }

  bool isEmailValid() {
    return email.trim().isNotEmpty;
  }

  bool isNewPasswordValid() {
    return isNewPasswordFilled()
        ? newPassword == newPasswordConfirmation
        : true;
  }

  bool isNewPasswordFilled() {
    return newPassword != null || newPasswordConfirmation != null;
  }
}
