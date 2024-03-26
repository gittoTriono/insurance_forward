class BankAccount {
  String? bankName;
  String? bankAccountNumber;
  String? namaBankAccount;
  String? currencyBank;

  BankAccount({
    this.bankName = '',
    this.bankAccountNumber = '',
    this.namaBankAccount = '',
    this.currencyBank = '',
  });

  factory BankAccount.fromJson(Map<String, dynamic> parsedJson) {
    //print('BankAccount.fromJson $parsedJson');
    return BankAccount(
      bankName: parsedJson['bankName'] as String?,
      bankAccountNumber: parsedJson['bankAccountNumber'] as String?,
      namaBankAccount: parsedJson['namaBankAccount'] as String?,
      currencyBank: parsedJson['currencyBank'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'bankName': bankName,
        'bankAccountNumber': bankAccountNumber,
        'namaBankAccount': namaBankAccount,
        'currencyBank': currencyBank,
      };
}
