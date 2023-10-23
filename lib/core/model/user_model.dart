class UserModel {
  String? email;
  String? password;
  String? name;
  UserModel({this.email, this.password, this.name});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        email: json['email'],
        password: json['password'],
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'password': password,
        'name': name,
      };
}
