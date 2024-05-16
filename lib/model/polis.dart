class Polis {
  String id;
  String polisDocId;
  int polisEndorsementNo;
  String tglPolis;
  int tglPolisMillis;
  String sppaId;
  String customerId;
  String namaTertanggung;
  String alamatCustomer;
  String kantorCabang;
  String jenisObject;
  String alamatKandang;
  double hargaPertanggungan;
  double premiRate;
  double premiAmount;
  double biayaAdministrasi;
  double beaMaterei;
  String salesId;
  String marketingId;
  String brokerId;
  String namaAsuransi;
  String produkName;

  String produkCode;
  String kategori;
  String subKategori;
  double nilaiPertanggunganSppa;
  int tenorSppa;
  String invoiceNo;
  String tglInvoice;
  int tglInvoiceMillis;
  double invoiceAmount;
  String tglPaymentDue;
  int tglPaymentDueMillis;
  String tglPayment;
  int tglPaymentMillis;
  double paymentTotalAmount;
  String buktiPembayaranUrl;
  int paymentStatus;
  int incomeDistributionStatus;
  String tglIncomeDistributionProcess;
  int incomeDistributionProcessNo;
  int tglAwalPolisMillis;
  String tglAwalPolis;
  int warrantyDays;
  String tglAkhirPolis;
  int tglAkhirPolisMillis;
  int statusPolis;
  int statusProses;

  Polis({
    this.id = '',
    this.polisDocId = '',
    this.polisEndorsementNo = 0,
    this.tglPolis = '',
    this.tglPolisMillis = 0,
    this.sppaId = '',
    this.customerId = '',
    this.namaTertanggung = '',
    this.alamatCustomer = '',
    this.kantorCabang = '',
    this.jenisObject = '',
    this.alamatKandang = '',
    this.hargaPertanggungan = 0,
    this.premiRate = 0,
    this.premiAmount = 0,
    this.biayaAdministrasi = 0,
    this.beaMaterei = 0,
    this.salesId = '',
    this.marketingId = '',
    this.brokerId = '',
    this.namaAsuransi = '',
    this.produkName = '',
    this.produkCode = '',
    this.kategori = '',
    this.subKategori = '',
    this.nilaiPertanggunganSppa = 0,
    this.tenorSppa = 0,
    this.invoiceNo = '',
    this.invoiceAmount = 0,
    this.tglInvoice = '',
    this.tglInvoiceMillis = 0,
    this.tglPaymentDue = '',
    this.tglPaymentDueMillis = 0,
    this.tglPayment = '',
    this.tglPaymentMillis = 0,
    this.paymentTotalAmount = 0,
    this.buktiPembayaranUrl = '',
    this.paymentStatus = 0,
    this.incomeDistributionStatus = 0,
    this.tglIncomeDistributionProcess = '',
    this.incomeDistributionProcessNo = 0,
    this.tglAwalPolisMillis = 0,
    this.tglAwalPolis = '',
    this.warrantyDays = 0,
    this.tglAkhirPolis = '',
    this.tglAkhirPolisMillis = 0,
    this.statusPolis = 0,
    this.statusProses = 0,
  });

  factory Polis.fromJson(Map<String, dynamic> parsedJson) {
    return Polis(
      id: parsedJson['id'] as String,
      polisDocId: parsedJson['polisDocId'] as String,
      polisEndorsementNo: parsedJson['polisEndorsementNo'] as int,
      tglPolis: parsedJson['tglPolis'] as String,
      tglPolisMillis: parsedJson['tglPolisMillis'] as int,
      sppaId: parsedJson['sppaId'] as String,
      customerId: parsedJson['customerId'] as String,
      namaTertanggung: parsedJson['namaTertanggung'] as String,
      alamatCustomer: parsedJson['alamatCustomer'] as String,
      kantorCabang: parsedJson['kantorCabang'] as String,
      jenisObject: parsedJson['jenisObject'] as String,
      alamatKandang: parsedJson['alamatKandang'] as String,
      hargaPertanggungan:
          parsedJson['hargaPertanggungan'].toDouble(), // as double,
      premiRate: parsedJson['premiRate'] as double,
      premiAmount: parsedJson['premiAmount'] as double,
      biayaAdministrasi: parsedJson['biayaAdministrasi'] as double,
      beaMaterei: parsedJson['beaMaterei'] as double,
      salesId: parsedJson['salesId'] as String,
      marketingId: parsedJson['marketingId'] as String,
      brokerId: parsedJson['brokerId'] as String,
      namaAsuransi: parsedJson['namaAsuransi'] as String,
      produkName: parsedJson['produkName'] as String,
      produkCode: parsedJson['produkCode'] as String,
      kategori: parsedJson['kategori'] as String,
      subKategori: parsedJson['subKategori'] as String,
      nilaiPertanggunganSppa:
          parsedJson['nilaiPertanggunganSppa'].toDouble(), // as double,
      tenorSppa: parsedJson['tenorSppa'] as int,
      invoiceNo: parsedJson['invoiceNo'] as String,
      invoiceAmount: parsedJson['invoiceAmount'] as double,
      tglInvoice: parsedJson['tglInvoice'] as String,
      tglInvoiceMillis: parsedJson['tglInvoiceMillis'] as int,
      tglPaymentDue: parsedJson['tglPaymentDue'] as String,
      tglPaymentDueMillis: parsedJson['tglPaymentDueMillis'] as int,
      tglPayment: parsedJson['tglPayment'] as String,
      tglPaymentMillis: parsedJson['tglPaymentMillis'] as int,
      paymentTotalAmount: parsedJson['paymentTotalAmount'] as double,
      buktiPembayaranUrl: parsedJson['buktiPembayaranUrl'] as String,
      paymentStatus: parsedJson['paymentStatus'] as int,
      incomeDistributionStatus: parsedJson['incomeDistributionStatus'] as int,
      tglIncomeDistributionProcess:
          parsedJson['tglIncomeDistributionProcess'] as String,
      incomeDistributionProcessNo:
          parsedJson['incomeDistributionProcessNo'] as int,
      tglAwalPolisMillis: parsedJson['tglAwalPolisMillis'] as int,
      tglAwalPolis: parsedJson['tglAwalPolis'] as String,
      warrantyDays: parsedJson['warrantyDays'] as int,
      tglAkhirPolis: parsedJson['tglAkhirPolis'] as String,
      tglAkhirPolisMillis: parsedJson['tglAkhirPolisMillis'] as int,
      statusPolis: parsedJson['statusPolis'] as int,
      statusProses: parsedJson['statusProses'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
// 'id': id,
        'polisDocId': polisDocId,
        'polisEndorsementNo': polisEndorsementNo,
        'tglPolis': tglPolis,
        'tglPolisMillis': tglPolisMillis,
        'sppaId': sppaId,
        'customerId': customerId,
        'alamatCustomer': alamatCustomer,
        'kantorCabang': kantorCabang,
        'jenisObject': jenisObject,
        'alamatKandang': alamatKandang,
        'namaTertanggung': namaTertanggung,
        'hargaPertanggungan': hargaPertanggungan,
        'premiRate': premiRate,
        'premiAmount': premiAmount,
        'biayaAdministrasi': biayaAdministrasi,
        'beaMaterei': beaMaterei,
        'salesId': salesId,
        'marketingId': marketingId,
        'brokerId': brokerId,
        'namaAsuransi': namaAsuransi,
        'produkName': produkName,

        'produkCode': produkCode,
        'kategori': kategori,
        'subKategori': subKategori,
        'nilaiPertanggunganSppa': nilaiPertanggunganSppa,
        'tenorSppa': tenorSppa,
        'invoiceNo': invoiceNo,
        'tglInvoice': tglInvoice,
        'invoiceAmount': invoiceAmount,

        'tglInvoiceMillis': tglInvoiceMillis,
        'tglPaymentDue': tglPaymentDue,
        'tglPaymentDueMillis': tglPaymentDueMillis,
        'tglPayment': tglPayment,
        'tglPaymentMillis': tglPaymentMillis,
        'paymentTotalAmount': paymentTotalAmount,
        'buktiPembayaranUrl': buktiPembayaranUrl,
        'paymentStatus': paymentStatus,
        'incomeDistributionStatus': incomeDistributionStatus,
        'tglIncomeDistributionProcess': tglIncomeDistributionProcess,
        'incomeDistributionProcessNo': incomeDistributionProcessNo,
        'tglAwalPolisMillis': tglAwalPolisMillis,
        'tglAwalPolis': tglAwalPolis,
        'warrantyDays': warrantyDays,
        'tglAkhirPolis': tglAkhirPolis,
        'tglAkhirPolisMillis': tglAkhirPolisMillis,
        'statusPolis': statusPolis,
        'statusProses': statusProses,
      };
}
