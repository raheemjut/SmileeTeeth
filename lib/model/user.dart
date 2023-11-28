//@dart=2.9
import 'package:meta/meta.dart';

import '../utils.dart';

class UserField {
  static final String lastMessageTime = 'lastMessageTime';
}

class User {
  final String idUser;
  final String name;
  final String urlAvatar;

  final String userpassword;

  const User({
    this.idUser,
    @required this.name,
    @required this.urlAvatar,
  
    @required this.userpassword
  });

  User copyWith({
    String idUser,
    String name,
    String urlAvatar,
  
    String userpassword
  }) =>
      User(
        idUser: idUser ?? this.idUser,
        name: name ?? this.name,
        urlAvatar: urlAvatar ?? this.urlAvatar,
     
        userpassword: userpassword ?? this.userpassword,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        idUser: json['idUser'],
        name: json['name'],
        urlAvatar: json['urlAvatar'],
        
        userpassword: json['userpassword']
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'name': name,
        'urlAvatar': urlAvatar,
        
        'userpassword':userpassword
      };
}
