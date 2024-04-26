class UserModel {
  String userId;
  String type; //[HP, EMAIL]
  String dob; //YYYY-MM-DD
  String pob;
  String imei;
  String roles; //[ROLE_REG, ROLE_
  String name;
  String alias;
  String status; //[U_REG, INACTIVE
  String account;
  bool accountNonExpired;
  bool enabled;
  bool locked;
  bool expired;
  String userTypes; //[U_REG, USER
  int trial;
  String chain;
  //String token;
  //String pass;
  String responseCode;
  String responseMessage;
  String partner;
  String classification;

  UserModel({
    this.userId = "",
    this.type = "",
    this.dob = "",
    this.pob = "",
    this.imei = "",
    this.roles = "",
    this.name = "",
    this.alias = "",
    this.status = "",
    this.account = "",
    this.accountNonExpired = false,
    this.enabled = false,
    this.locked = false,
    this.expired = true,
    this.userTypes = "",
    this.trial = 0,
    this.chain = "",
    //this.token="",
    //this.pass="",
    this.responseCode = "",
    this.responseMessage = "",
    this.partner = "",
    this.classification = "",
  });

  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return UserModel(
      userId: parsedJson['userId'] as String,
      type: parsedJson['type'] as String,
      dob: parsedJson['dob'] as String,
      pob: parsedJson['pob'] as String,
      imei: parsedJson['imei'] as String,
      roles: parsedJson['roles'] as String,
      name: parsedJson['name'] as String,
      alias: parsedJson['alias'] as String,
      status: parsedJson['status'] as String,
      account: parsedJson['account'] as String,
      accountNonExpired: parsedJson['accountNonExpired'] as bool,
      enabled: parsedJson['enabled'] as bool,
      locked: parsedJson['locked'] as bool,
      expired: parsedJson['expired'] as bool,
      userTypes: parsedJson['userTypes'] as String,
      trial: parsedJson['trial'] as int,
      chain: parsedJson['chain'] as String,
      //token: parsedJson['token'] as String,
      //pass: parsedJson['pass'] as String,
      responseCode: parsedJson['responseCode'] as String,
      responseMessage: parsedJson['responseMessage'] as String,
      partner: parsedJson['partner'] as String,
      classification: parsedJson['classification'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'type': type,
        'dob': dob,
        'pob': pob,
        'imei': imei,
        'roles': roles,
        'name': name,
        'alias': alias,
        'status': status,
        'account': account,
        'accountNonExpired': accountNonExpired,
        'enabled': enabled,
        'locked': locked,
        'expired': expired,
        'userTypes': userTypes,
        'trial': trial,
        'chain': chain,
        //'token': token,
        //'pass': pass,
        'responseCode': responseCode,
        'responseMessage': responseMessage,
        'partner': partner,
        'classification': classification,
      };
}

class RegistrationModel {
  String userId;
  String type; //[HP, EMAIL]
  String dob; //YYYY-MM-DD
  String pob;
  String imei;
  String roles; //[ROLE_REG, ROLE_
  String name;
  String alias;
  String status; //[U_REG, INACTIVE
  String account;
  bool accountNonExpired;
  bool enabled;
  bool locked;
  bool expired;
  String userTypes; //[U_REG, USER
  int trial;
  String chain;
  String token;
  String pass;
  String responseCode;
  String responseMessage;
  String partner;
  String classification;

  RegistrationModel({
    this.userId = "",
    this.type = "",
    this.dob = "",
    this.pob = "",
    this.imei = "",
    this.roles = "",
    this.name = "",
    this.alias = "",
    this.status = "",
    this.account = "",
    this.accountNonExpired = false,
    this.enabled = false,
    this.locked = false,
    this.expired = true,
    this.userTypes = "",
    this.trial = 0,
    this.chain = "",
    this.token = "",
    this.pass = "",
    this.responseCode = "",
    this.responseMessage = "",
    this.partner = "",
    this.classification = "",
  });

  factory RegistrationModel.fromJson(Map<String, dynamic> parsedJson) {
    return RegistrationModel(
      userId: parsedJson['userId'] as String,
      type: parsedJson['type'] as String,
      dob: parsedJson['dob'] as String,
      pob: parsedJson['pob'] as String,
      imei: parsedJson['imei'] as String,
      roles: parsedJson['roles'] as String,
      name: parsedJson['name'] as String,
      alias: parsedJson['alias'] as String,
      status: parsedJson['status'] as String,
      account: parsedJson['account'] as String,
      accountNonExpired: parsedJson['accountNonExpired'] as bool,
      enabled: parsedJson['enabled'] as bool,
      locked: parsedJson['locked'] as bool,
      expired: parsedJson['expired'] as bool,
      userTypes: parsedJson['userTypes'] as String,
      trial: parsedJson['trial'] as int,
      chain: parsedJson['chain'] as String,
      token: parsedJson['token'] as String,
      pass: parsedJson['pass'] as String,
      responseCode: parsedJson['responseCode'] as String,
      responseMessage: parsedJson['responseMessage'] as String,
      partner: parsedJson['partner'] as String,
      classification: parsedJson['classification'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'type': type,
        'dob': dob,
        'pob': pob,
        'imei': imei,
        'roles': roles,
        'name': name,
        'alias': alias,
        'status': status,
        'account': account,
        'accountNonExpired': accountNonExpired,
        'enabled': enabled,
        'locked': locked,
        'expired': expired,
        'userTypes': userTypes,
        'trial': trial,
        'chain': chain,
        'token': token,
        'pass': pass,
        'responseCode': responseCode,
        'responseMessage': responseMessage,
        'partner': partner,
        'classification': classification,
      };
}

class SimpleUserModel {
  String userId;
  String token;
  String responseCode;
  String responseMessage;

  SimpleUserModel({
    this.userId = "",
    this.token = "",
    this.responseCode = "",
    this.responseMessage = "",
  });

  factory SimpleUserModel.fromJson(Map<String, dynamic> parsedJson) {
    return SimpleUserModel(
      userId: parsedJson['userId'] as String,
      token: parsedJson['token'] as String,
      responseCode: parsedJson['responseCode'] as String,
      responseMessage: parsedJson['responseMessage'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'token': token,
        'responseCode': responseCode,
        'responseMessage': responseMessage,
      };
}
