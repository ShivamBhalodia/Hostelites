class RegisterConsumer {
  bool isUser = true;
  String name = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  String otp = "";

  RegisterConsumer({
    required this.isUser,
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.otp,
  });
}
