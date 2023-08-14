class RegisterRequestModel {
  final String username;
  final String password;
  final String email;

  RegisterRequestModel({
    required this.username,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'email': email,
      };
}
