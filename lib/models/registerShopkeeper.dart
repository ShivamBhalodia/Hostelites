class RegisterShopkeeper {
  bool isUser = true;
  String name = "";
  String phone = "";
  String password = "";
  String confirmPassword = "";
  String otp = "";

  RegisterShopkeeper({
    required this.isUser,
    required this.name,
    required this.phone,
    required this.password,
    required this.confirmPassword,
    required this.otp,
  });
}
