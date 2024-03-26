import '/model/alamat.dart';
import 'bank_account.dart';

class Customer {
  String? id;
  String? customerId;
  String? fullName;
  Alamat? alamat;
  String? ktp;
  String? npwp;
  String? noTelp;
  String? email;
  String? pekerjaan;
  Alamat? alamatKantor;
  String? salesId;
  String? marketingId;
  String? brokerId;
  BankAccount? bankAccount;
  String? codeUpline;
  String? custGroupCode;
  String? groupName;
  int? tglRegistrasiMillis;
  String? tglRegistrasi;
  String? status;

  Customer({
    this.id = '',
    this.customerId = '',
    this.fullName = '',
    this.alamat,
    this.ktp = '',
    this.npwp = '',
    this.noTelp = '',
    this.email = '',
    this.pekerjaan = '',
    this.alamatKantor,
    this.salesId = '',
    this.marketingId = '',
    this.brokerId = '',
    this.bankAccount,
    this.codeUpline = '',
    this.custGroupCode = '',
    this.groupName = '',
    this.tglRegistrasiMillis = 0,
    this.tglRegistrasi = '',
    this.status = '',
  });

  factory Customer.fromJson(Map<String, dynamic> parsedJson) {
    // print('bankAccount di Customer.fromJson : ${parsedJson['bankAccount']}');

    return Customer(
      id: parsedJson['id'] as String?,
      customerId: parsedJson['customerId'] as String?,
      fullName: parsedJson['fullName'] as String?,
      alamat: parsedJson['alamat'] == null
          ? null
          : Alamat.fromJson(parsedJson['alamat'] as Map<String, dynamic>),
      ktp: parsedJson['ktp'] as String?,
      npwp: parsedJson['npwp'] as String?,
      noTelp: parsedJson['noTelp'] as String?,
      email: parsedJson['email'] as String?,
      pekerjaan: parsedJson['pekerjaan'] as String?,
      alamatKantor: parsedJson['alamatKantor'] == null
          ? null
          : Alamat.fromJson(parsedJson['alamatKantor'] as Map<String, dynamic>),
      salesId: parsedJson['salesId'] as String?,
      marketingId: parsedJson['marketingId'] as String?,
      brokerId: parsedJson['brokerId'] as String?,
      bankAccount: parsedJson['bankAccount'] == null
          ? null
          : BankAccount.fromJson(
              parsedJson['bankAccount'] as Map<String, dynamic>),
      codeUpline: parsedJson['codeUpline'] as String?,
      custGroupCode: parsedJson['custGroupCode'] as String?,
      groupName: parsedJson['groupName'] as String?,
      tglRegistrasiMillis: parsedJson['tglRegistrasiMillis'] as int?,
      tglRegistrasi: parsedJson['tglRegistrasi'] as String?,
      status: parsedJson['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'customerId': customerId,
        'fullName': fullName,
        'alamat': alamat?.toJson(),
        'ktp': ktp,
        'npwp': npwp,
        'noTelp': noTelp,
        'email': email,
        'pekerjaan': pekerjaan,
        'alamatKantor': alamatKantor?.toJson(),
        'salesId': salesId,
        'marketingId': marketingId,
        'brokerId': brokerId,
        'bankAccount': bankAccount?.toJson(),
        'codeUpline': codeUpline,
        'custGroupCode': custGroupCode,
        'groupName': groupName,
        'tglRegistrasiMillis': tglRegistrasiMillis,
        'tglRegistrasi': tglRegistrasi,
        'status': status,
      };
}
