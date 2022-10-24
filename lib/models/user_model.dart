import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? name;
  final String? email;
  final String? profilePic;
  final String uid;
  final String token;

  UserModel(
    this.name,
    this.email,
    this.profilePic,
    this.uid,
    this.token,
  );

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? uid,
    String? token,
  }) {
    return UserModel(
      name ?? this.name,
      email ?? this.email,
      profilePic ?? this.profilePic,
      uid ?? this.uid,
      token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'uid': uid,
      'token': token,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      map['name'] as String,
      map['email'] as String,
      map['profilePic'] as String,
      map['uid'] as String,
      map['token'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, profilePic: $profilePic, uid: $uid, token: $token)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.token == token;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        token.hashCode;
  }
}
