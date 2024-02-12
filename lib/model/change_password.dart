class ChangePassword {

  final String userId;
  final String oldPass;
  final String newPass;
  final String token;
  final String responseCode;
  final String responseMessage;

  ChangePassword({

    this.userId='',
    this.oldPass='',
    this.newPass='',
    this.token='',
    this.responseCode='',
    this.responseMessage='',

  });

  factory ChangePassword.fromJson(Map<String, dynamic> parsedJson){
    return ChangePassword(
      userId: parsedJson['userId'] as String,
      oldPass: parsedJson['oldPass'] as String,
      newPass: parsedJson['newPass'] as String,
      token: parsedJson['token'] as String,
      responseCode: parsedJson['responseCode'] as String,
      responseMessage: parsedJson['responseMessage'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'oldPass': oldPass,
    'newPass': newPass,
    'token': token,
    'responseCode': responseCode,
    'responseMessage': responseMessage,
  };

}