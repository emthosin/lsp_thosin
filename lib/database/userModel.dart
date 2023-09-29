class UserModel {
  int id;
  String username, password;

  UserModel({
    this.id,
    this.username,
    this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json["id"],
      username: json["username"],
      password: json["password"],
    );
  }
}
