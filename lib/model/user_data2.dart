class Customer2 {
  String? id;
  String? type;
  String? name;
  String? noHp;
  String? email;
  String? pekerjaan;
  String? kelompok;
  String? noAnggota;
  String? jalan;
  String? rt;
  String? rw;
  String? kelurahan;
  String? kecamatan;
  String? kota;
  String? kabupaten;
  String? kodePos;
  String? bankName;
  String? bankAccountNumber;
  String? bankAccountNama;
  String? ktp;
  String? dob;
  String? pob;
  String? imei;
  String? roles;
  String? alias;
  String? status;
  int? tglRegistrasiMillis;
  String? tglRegistrasi;

  String? account;
  bool? accountNonExpired;
  bool? enabled;
  bool? locked;
  bool? expired;
  String? userTypes;
  int? trial;
  String? chain; // saledId
  String? salesId; // saledId
  String? marketingId; // saledId
  String? brokerId; // saledId
//String	token	;
//String	pass	;
  String? responseCode;
  String? responseMessage;
  String? partner;
  String? classification;

  Customer2({
    this.id = '',
    this.type = '',
    this.name = '',
    this.noHp = '',
    this.email = '',
    this.pekerjaan = '',
    this.kelompok = '',
    this.noAnggota = '',
    this.jalan = '',
    this.rt = '',
    this.rw = '',
    this.kelurahan = '',
    this.kecamatan = '',
    this.kota = '',
    this.kabupaten = '',
    this.kodePos = '',
    this.bankName = '',
    this.bankAccountNumber = '',
    this.bankAccountNama = '',
    this.ktp = '',
    this.dob = '',
    this.pob = '',
    this.imei = '',
    this.roles = '',
    this.alias = '',
    this.status = '',
    this.tglRegistrasiMillis = 0,
    this.tglRegistrasi = '',
    this.account = '',
    this.accountNonExpired = true,
    this.enabled = true,
    this.locked = false,
    this.expired = false,
    this.userTypes = '',
    this.trial = 0,
    this.chain = '',
    this.salesId = '',
    this.marketingId = '',
    this.brokerId = '',

// this.token	='' ,
// this.pass	='' ,
    this.responseCode = '',
    this.responseMessage = '',
    this.partner = '',
    this.classification = '',
  });

  factory Customer2.fromJson(Map<String, dynamic> parsedJson) {
    return Customer2(
      id: parsedJson['id'] as String?,
      type: parsedJson['type'] as String?,
      name: parsedJson['name'] as String?,
      noHp: parsedJson['noHp'] as String?,
      email: parsedJson['email'] as String?,
      pekerjaan: parsedJson['pekerjaan'] as String?,
      kelompok: parsedJson['kelompok'] as String?,
      noAnggota: parsedJson['noAnggota'] as String?,
      jalan: parsedJson['jalan'] as String?,
      rt: parsedJson['rt'] as String?,
      rw: parsedJson['rw'] as String?,
      kelurahan: parsedJson['kelurahan'] as String?,
      kecamatan: parsedJson['kecamatan'] as String?,
      kota: parsedJson['kota'] as String?,
      kabupaten: parsedJson['kabupaten'] as String?,
      kodePos: parsedJson['kodePos'] as String?,
      bankName: parsedJson['bankName'] as String?,
      bankAccountNumber: parsedJson['bankAccountNumber'] as String?,
      bankAccountNama: parsedJson['bankAccountNama'] as String?,
      ktp: parsedJson['ktp'] as String?,
      dob: parsedJson['dob'] as String?,
      pob: parsedJson['pob'] as String?,
      imei: parsedJson['imei'] as String?,
      roles: parsedJson['roles'] as String?,
      alias: parsedJson['alias'] as String?,
      status: parsedJson['status'] as String?,
      tglRegistrasiMillis: parsedJson['tglRegistrasiMillis'] as int?,
      tglRegistrasi: parsedJson['tglRegistrasi'] as String?,
      account: parsedJson['account'] as String?,
      accountNonExpired: parsedJson['accountNonExpired'] as bool?,
      enabled: parsedJson['enabled'] as bool?,
      locked: parsedJson['locked'] as bool?,
      expired: parsedJson['expired'] as bool?,
      userTypes: parsedJson['userTypes'] as String?,
      trial: parsedJson['trial'] as int?,
      chain: parsedJson['chain'] as String?,
      salesId: parsedJson['salesId'] as String?,
      marketingId: parsedJson['marketingId'] as String?,
      brokerId: parsedJson['brokerId'] as String?,
// token: parsedJson['token'] as //String,
// pass: parsedJson['pass'] as //String,
      responseCode: parsedJson['responseCode'] as String?,
      responseMessage: parsedJson['responseMessage'] as String?,
      partner: parsedJson['partner'] as String?,
      classification: parsedJson['classification'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        //'id': id,
        'type': type,
        'name': name,
        'noHp': noHp,
        'email': email,
        'pekerjaan': pekerjaan,
        'kelompok': kelompok,
        'noAnggota': noAnggota,
        'jalan': jalan,
        'rt': rt,
        'rw': rw,
        'kelurahan': kelurahan,
        'kecamatan': kecamatan,
        'kota': kota,
        'kabupaten': kabupaten,
        'kodePos': kodePos,
        'bankName': bankName,
        'bankAccountNumber': bankAccountNumber,
        'bankAccountNama': bankAccountNama,
        'ktp': ktp,
        'dob': dob,
        'pob': pob,
        'imei': imei,
        'roles': roles,
        'alias': alias,
        'status': status,
        'tglRegistrasiMillis': tglRegistrasiMillis,
        'tglRegistrasi': tglRegistrasi,

        'account': account,
        'accountNonExpired': accountNonExpired,
        'enabled': enabled,
        'locked': locked,
        'expired': expired,
        'userTypes': userTypes,
        'trial': trial,
        'chain': chain,
        'salesId': salesId,
        'marketingId': marketingId,
        'brokerId': brokerId,
        // 'token': token,
// 'pass': pass,
        'responseCode': responseCode,
        'responseMessage': responseMessage,
        'partner': partner,
        'classification': classification,
      };
}
