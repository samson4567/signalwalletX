class NewUserRequestModel {
  final String email;
  final String password;
  final String passwordConfirmation;

  NewUserRequestModel({
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }

 
  factory NewUserRequestModel.fromJson(Map<String, dynamic> json) {
    return NewUserRequestModel(
      email: json['email'],
      password: json['password'],
      passwordConfirmation: json['password_confirmation'],
    );
  }
}

