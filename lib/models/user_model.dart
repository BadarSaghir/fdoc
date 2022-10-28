import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String? name;
  final String? email;
  final String? profilePic;
  String? uid = '';
  String? token = '';
  String? googleToken = '';
  UserModel({
    this.name,
    this.email,
    this.profilePic,
    this.uid,
    this.token,
    this.googleToken,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? profilePic,
    String? uid,
    String? token,
    String? googleToken,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      profilePic: profilePic ?? this.profilePic,
      uid: uid ?? this.uid,
      token: token ?? this.token,
      googleToken: googleToken ?? this.googleToken,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'profilePic': profilePic,
      'uid': uid,
      'token': token,
      'googleToken': googleToken,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      profilePic:
          map['profilePic'] != null ? map['profilePic'] as String : null,
      uid: map['uid'] ?? '',
      token: map['token'] ?? '',
      googleToken: map['googleToken'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(name: $name, email: $email, profilePic: $profilePic, uid: $uid, token: $token, googleToken: $googleToken)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.email == email &&
        other.profilePic == profilePic &&
        other.uid == uid &&
        other.token == token &&
        other.googleToken == googleToken;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        profilePic.hashCode ^
        uid.hashCode ^
        token.hashCode ^
        googleToken.hashCode;
  }
}
