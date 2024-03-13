class UserModel {
  String name, email, password, user_id, imageUrl, createdOn;
  bool isAdmin, isActive;

  UserModel({
    required this.name,
    required this.email,
    required this.password,
    required this.user_id,
    required this.imageUrl,
    required this.createdOn,
    required this.isAdmin,
    required this.isActive,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'password': this.password,
      'user_id': this.user_id,
      'imageUrl': this.imageUrl,
      'createdOn': this.createdOn,
      'isAdmin': this.isAdmin,
      'isActive': this.isActive,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      user_id: map['user_id'] as String,
      imageUrl: map['imageUrl'] as String,
      createdOn: map['createdOn'] as String,
      isAdmin: map['isAdmin'] as bool,
      isActive: map['isActive'] as bool,
    );
  }
}
