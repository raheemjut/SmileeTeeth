//@dart=2.9
import 'package:meta/meta.dart';

// ignore: import_of_legacy_library_into_null_safe


class MessageField {
  static final String message = 'message';
  static final String createdAt = 'createdAt';
}

class Message {
  final String idUser;
  final String urlAvatar;
  final String username;
  final String message;

  final Message replyMessage;

  const Message({
    @required this.idUser,
    @required this.urlAvatar,
    @required this.username,
    @required this.message,
  
    @required this.replyMessage,
  });

  static Message fromJson(Map<String, dynamic> json) => Message(
        idUser: json['idUser'],
        urlAvatar: json['urlAvatar'],
        username: json['username'],
        message: json['message'],
        
        replyMessage: json['replyMessage'] == null
            ? null
            : Message.fromJson(json['replyMessage']),
      );

  Map<String, dynamic> toJson() => {
        'idUser': idUser,
        'urlAvatar': urlAvatar,
        'username': username,
        'message': message,
        
        'replyMessage': replyMessage == null ? null : replyMessage.toJson(),
      };
}
