import 'package:get/get.dart';

class SppaHeader {
  String? id;
  String? sppaId;
  String? customerId;
  String? salesId;
  String? marketingId;
  String? brokerId;
  String? asuransiName;
  String? produkCode;
  String? produkName;
  String? kategori;
  String? subKategori;
  int? statusSppa;
  double? nilaiPertanggungan;
  int? tenor;
  double? premiRate;
  double? premiAmount;
  String? polisId;

  SppaHeader({
    this.id = '',
    this.sppaId = '',
    this.customerId = '',
    this.salesId = '',
    this.marketingId = '',
    this.brokerId = '',
    this.asuransiName = '',
    this.produkCode = '',
    this.produkName = '',
    this.kategori = '',
    this.subKategori = '',
    this.statusSppa = 0,
    this.nilaiPertanggungan = 0,
    this.tenor = 0,
    this.premiRate = 0,
    this.premiAmount = 0,
    this.polisId = '',
  });

  factory SppaHeader.fromJson(Map<String, dynamic> parsedJson) {
    return SppaHeader(
      id: parsedJson['id'] as String?,
      sppaId: parsedJson['sppaId'] as String?,
      customerId: parsedJson['customerId'] as String?,
      salesId: parsedJson['salesId'] as String?,
      marketingId: parsedJson['marketingId'] as String?,
      brokerId: parsedJson['brokerId'] as String?,
      asuransiName: parsedJson['asuransiName'] as String?,
      produkCode: parsedJson['produkCode'] as String?,
      produkName: parsedJson['produkName'] as String?,
      kategori: parsedJson['kategori'] as String?,
      subKategori: parsedJson['subKategori'] as String?,
      statusSppa: parsedJson['statusSppa'] as int?,
      nilaiPertanggungan:
          parsedJson['nilaiPertanggungan'].toDouble(), // as double?,
      tenor: parsedJson['tenor'] as int?,
      premiRate: parsedJson['premiRate'] as double?,
      premiAmount: parsedJson['premiAmount'].toDouble(), // as double?,
      polisId: parsedJson['polisId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
//        'id': id,   // to autocreate id
        'sppaId': sppaId,
        'customerId': customerId,
        'salesId': salesId,
        'marketingId': marketingId,
        'brokerId': brokerId,
        'asuransiName': asuransiName,
        'produkCode': produkCode,
        'produkName': produkName,
        'kategori': kategori,
        'subKategori': subKategori,
        'statusSppa': statusSppa,
        'nilaiPertanggungan': nilaiPertanggungan,
        'tenor': tenor,
        'premiRate': premiRate,
        'premiAmount': premiAmount,
        'polisId': polisId,
      };
}

class SppaStatus {
  String? id;
  String? sppaId;
  int? statusSppa;
  int? initSubmitDtMillis;
  String? initSubmitDt;
  int? tglSubmitSalesMillis;
  String? tglSubmitSales;
  int? tglReviewSalesMillis;
  String? tglReviewSales;
  String? salesNote;
  int? tglRecapMillis;
  String? tglRecap;
  String? recapSppaId;
  // int? tglReviewBroker;
  // String? tglReviewBrokerMillis;
  // String? brokerNote;
  // int? tglSubmitAsuransiMillis;
  // String? tglSubmitAsuransi;
  int? tglResponseAsuransiMillis;
  String? tglResponseAsuransi;
  int? statusResponseAsuransi;
  String? asuransiNote;
  String? tglCreated;
  int? tglCreatedMillis;
  String? tglLastUpdate;
  int? tglLastUpdateMillis;

  SppaStatus({
    this.id = '',
    this.sppaId = '',
    this.statusSppa = 0,
    this.initSubmitDtMillis = 0,
    this.initSubmitDt = '',
    this.tglSubmitSalesMillis = 0,
    this.tglSubmitSales = '',
    this.tglReviewSalesMillis = 0,
    this.tglReviewSales = '',
    this.salesNote = '',
    this.tglRecapMillis = 0,
    this.tglRecap = '',
    this.recapSppaId = '',
    // this.tglReviewBroker = 0,
    // this.tglReviewBrokerMillis = '',
    // this.brokerNote = '',
    // this.tglSubmitAsuransiMillis = 0,
    // this.tglSubmitAsuransi = '',
    this.tglResponseAsuransiMillis = 0,
    this.tglResponseAsuransi = '',
    this.statusResponseAsuransi = 0,
    this.asuransiNote = '',
    this.tglCreated = '',
    this.tglCreatedMillis = 0,
    this.tglLastUpdate = '',
    this.tglLastUpdateMillis = 0,
  });

  factory SppaStatus.fromJson(Map<String, dynamic> parsedJson) {
    return SppaStatus(
      id: parsedJson['id'] as String?,
      sppaId: parsedJson['sppaId'] as String?,
      initSubmitDtMillis: parsedJson['initSubmitDtMillis']
          as int?, // DateTime.parse(map['date']),
      initSubmitDt: parsedJson['initSubmitDt'] as String?,
      statusSppa: parsedJson['statusSppa'] as int?,
      tglSubmitSalesMillis: parsedJson['tglSubmitSalesMillis'] as int?,
      tglSubmitSales: parsedJson['tglSubmitSales'] as String?,
      tglReviewSalesMillis: parsedJson['tglReviewSalesMillis'] as int?,
      tglReviewSales: parsedJson['tglReviewSales'] as String?,
      salesNote: parsedJson['salesNote'] as String?,
      tglRecapMillis: parsedJson['tglRecapMillis'] as int?,
      tglRecap: parsedJson['tglRecap'] as String?,
      recapSppaId: parsedJson['recapSppaId'] as String?,
      // tglReviewBroker: parsedJson['tglReviewBroker'] as int?,
      // tglReviewBrokerMillis: parsedJson['tglReviewBrokerMillis'] as String?,
      // brokerNote: parsedJson['brokerNote'] as String?,
      // tglSubmitAsuransiMillis: parsedJson['tglSubmitAsuransiMillis'] as int?,
      // tglSubmitAsuransi: parsedJson['tglSubmitAsuransi'] as String?,
      tglResponseAsuransiMillis:
          parsedJson['tglResponseAsuransiMillis'] as int?,
      tglResponseAsuransi: parsedJson['tglResponseAsuransi'] as String?,
      statusResponseAsuransi: parsedJson['statusResponseAsuransi'] as int?,
      asuransiNote: parsedJson['asuransiNote'] as String?,
      tglCreated: parsedJson['tglCreated'] as String?,
      tglCreatedMillis: parsedJson['tglCreatedMillis'] as int?,
      tglLastUpdate: parsedJson['tglLastUpdate'] as String?,
      tglLastUpdateMillis: parsedJson['tglLastUpdateMillis'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
//        'id': id,    // to autocreate id
        'sppaId': sppaId,
        'initSubmitDtMillis': initSubmitDtMillis,
        'initSubmitDt': initSubmitDt,
        'statusSppa': statusSppa,
        'tglSubmitSalesMillis': tglSubmitSalesMillis,
        'tglSubmitSales': tglSubmitSales,
        'tglReviewSalesMillis': tglReviewSalesMillis,
        'tglReviewSales': tglReviewSales,
        'salesNote': salesNote,
        'tglRecapMillis': tglRecapMillis,
        'tglRecap': tglRecap,
        'recapSppaId': recapSppaId,
        // 'tglReviewBroker': tglReviewBroker,
        // 'tglReviewBrokerMillis': tglReviewBrokerMillis,
        // 'brokerNote': brokerNote,
        // 'tglSubmitAsuransiMillis': tglSubmitAsuransiMillis,
        // 'tglSubmitAsuransi': tglSubmitAsuransi,
        'tglResponseAsuransiMillis': tglResponseAsuransiMillis,
        'tglResponseAsuransi': tglResponseAsuransi,
        'statusResponseAsuransi': statusResponseAsuransi,
        'asuransiNote': asuransiNote,
        'tglCreated': tglCreated,
        'tglCreatedMillis': tglCreatedMillis,
        'tglLastUpdate': tglLastUpdate,
        'tglLastUpdateMillis': tglLastUpdateMillis,
      };
}
