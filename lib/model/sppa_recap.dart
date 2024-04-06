class RecapSppaHeader {
  String? id;
  String? docId;
  int? recapSppaStatus;
  String? salesId;
  String? marketingId;
  String? brokerId;
  String? produkAsuransiCode;
  String? produkAsuransiNama;
  String? codeAsuransi;
  int? jumlahSppa;
  int? jumlahTernak;
  double? totalNilaiPertanggungan;
  double? totalNilaiPremi;
  String? polisId;
  String? tglPolis;
  int? tglPolisMillis;
  String? tglPolisDistributed;
  int? tglPolisDistributedMillis;

  RecapSppaHeader({
    this.id = '',
    this.docId = '',
    this.recapSppaStatus = 0,
    this.salesId = '',
    this.marketingId = '',
    this.brokerId = '',
    this.produkAsuransiCode = '',
    this.produkAsuransiNama = '',
    this.codeAsuransi = '',
    this.jumlahSppa = 0,
    this.jumlahTernak = 0,
    this.totalNilaiPertanggungan = 0.0,
    this.totalNilaiPremi = 0.0,
    this.polisId = '',
    this.tglPolis = '',
    this.tglPolisMillis = 0,
    this.tglPolisDistributed = '',
    this.tglPolisDistributedMillis = 0,
  });

  factory RecapSppaHeader.fromJson(Map<String, dynamic> parsedJson) {
    return RecapSppaHeader(
      id: parsedJson['id'] as String?,
      docId: parsedJson['docId'] as String?,
      recapSppaStatus: parsedJson['recapSppaStatus'] as int?,
      salesId: parsedJson['salesId'] as String?,
      marketingId: parsedJson['marketingId'] as String?,
      brokerId: parsedJson['brokerId'] as String?,
      produkAsuransiCode: parsedJson['produkAsuransiCode'] as String?,
      produkAsuransiNama: parsedJson['produkAsuransiNama'] as String?,
      codeAsuransi: parsedJson['codeAsuransi'] as String?,
      jumlahSppa: parsedJson['jumlahSppa'] as int?,
      jumlahTernak: parsedJson['jumlahTernak'] as int?,
      totalNilaiPertanggungan: parsedJson['totalNilaiPertanggungan'].toDouble(),
      totalNilaiPremi: parsedJson['totalNilaiPremi'].toDouble(),
      polisId: parsedJson['polisId'] as String?,
      tglPolis: parsedJson['tglPolis'] as String?,
      tglPolisMillis: parsedJson['tglPolisMillis'] as int?,
      tglPolisDistributed: parsedJson['tglPolisDistributed'] as String?,
      tglPolisDistributedMillis:
          parsedJson['tglPolisDistributedMillis'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'docId': docId,
        'recapSppaStatus': recapSppaStatus,
        'salesId': salesId,
        'marketingId': marketingId,
        'brokerId': brokerId,
        'produkAsuransiCode': produkAsuransiCode,
        'produkAsuransiNama': produkAsuransiNama,
        'codeAsuransi': codeAsuransi,
        'jumlahSppa': jumlahSppa,
        'jumlahTernak': jumlahTernak,
        'totalNilaiPertanggungan': totalNilaiPertanggungan,
        'totalNilaiPremi': totalNilaiPremi,
        'polisId': polisId,
        'tglPolis': tglPolis,
        'tglPolisMillis': tglPolisMillis,
        'tglPolisDistributed': tglPolisDistributed,
        'tglPolisDistributedMillis': tglPolisDistributedMillis,
      };
}

//  **************************************************************************

class RecapSppaStatus {
  String? id;
  String? recapHeaderId;
  int? recapSppaStatus;
  String? tglCreated;
  int? tglCreatedMillis;
  String? createdBy;
  int? tglSubmitMarketingMillis;
  String? tglSubmitMarketing;
  String? submitMarketingBy;
  String? marketingNote;
  int? tglSubmitBrokerMillis;
  String? tglSubmitBroker;
  String? submitBrokerBy;
  int? tglReviewBroker;
  String? tglReviewBrokerMillis;
  String? brokerNote;
  int? tglSubmitAsuransiMillis;
  String? tglSubmitAsuransi;
  int? tglResponseAsuransiMillis;
  String? tglResponseAsuransi;
  int? statusResponseAsuransi;
  String? asuransiNote;

  RecapSppaStatus(
      {this.id = '',
      this.recapHeaderId = '',
      this.recapSppaStatus = 0,
      this.tglCreated = '',
      this.tglCreatedMillis = 0,
      this.tglSubmitMarketingMillis = 0,
      this.tglSubmitMarketing = '',
      this.submitMarketingBy = '',
      this.marketingNote = '',
      this.tglSubmitBrokerMillis = 0,
      this.tglSubmitBroker = '',
      this.submitBrokerBy = '',
      this.tglReviewBroker = 0,
      this.tglReviewBrokerMillis = '',
      this.brokerNote = '',
      this.tglSubmitAsuransiMillis = 0,
      this.tglSubmitAsuransi = '',
      this.tglResponseAsuransiMillis = 0,
      this.tglResponseAsuransi = '',
      this.statusResponseAsuransi = 0,
      this.asuransiNote = ''});

  factory RecapSppaStatus.fromJson(Map<String, dynamic> parsedJson) {
    return RecapSppaStatus(
      id: parsedJson['id'] as String?,
      recapHeaderId: parsedJson['recapHeaderId'] as String?,
      recapSppaStatus: parsedJson['recapSppaStatus'] as int?,
      tglCreated: parsedJson['tglCreated'] as String?,
      tglCreatedMillis: parsedJson['tglCreatedMillis'] as int?,
      tglSubmitMarketingMillis: parsedJson['tglSubmitMarketingMillis'] as int?,
      submitMarketingBy: parsedJson['submitMarketingBy'] as String?,
      marketingNote: parsedJson['marketingNote'] as String?,
      tglSubmitBrokerMillis: parsedJson['tglSubmitBrokerMillis'] as int?,
      tglSubmitBroker: parsedJson['tglSubmitBroker'] as String?,
      submitBrokerBy: parsedJson['submitBrokerBy'] as String?,
      tglReviewBroker: parsedJson['tglReviewBroker'] as int?,
      tglReviewBrokerMillis: parsedJson['tglReviewBrokerMillis'] as String?,
      brokerNote: parsedJson['brokerNote'] as String?,
      tglSubmitAsuransiMillis: parsedJson['tglSubmitAsuransiMillis'] as int?,
      tglSubmitAsuransi: parsedJson['tglSubmitAsuransi'] as String?,
      tglResponseAsuransiMillis:
          parsedJson['tglResponseAsuransiMillis'] as int?,
      tglResponseAsuransi: parsedJson['tglResponseAsuransi'] as String?,
      statusResponseAsuransi: parsedJson['statusResponseAsuransi'] as int?,
      asuransiNote: parsedJson['asuransiNote'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
//  'id': id,
        'recapHeaderId': recapHeaderId,
        'recapSppaStatus': recapSppaStatus,
        'tglCreated': tglCreated,
        'tglCreatedMillis': tglCreatedMillis,
        'tglSubmitMarketingMillis': tglSubmitMarketingMillis,
        'tglSubmitMarketing': tglSubmitMarketing,
        'submitMarketingBy': submitMarketingBy,
        'marketingNote': marketingNote,
        'tglSubmitBrokerMillis': tglSubmitBrokerMillis,
        'tglSubmitBroker': tglSubmitBroker,
        'submitBrokerBy': submitBrokerBy,
        'tglReviewBroker': tglReviewBroker,
        'tglReviewBrokerMillis': tglReviewBrokerMillis,
        'brokerNote': brokerNote,
        'tglSubmitAsuransiMillis': tglSubmitAsuransiMillis,
        'tglSubmitAsuransi': tglSubmitAsuransi,
        'tglResponseAsuransiMillis': tglResponseAsuransiMillis,
        'tglResponseAsuransi': tglResponseAsuransi,
        'statusResponseAsuransi': statusResponseAsuransi,
        'asuransiNote': asuransiNote,
      };
}

// ***************************************************************************

class RecapSppaDetail {
  String? id;
  String? recapHeaderId;
  String? sppaId;
  String? produkAsuransiCode;
  String? produkAsuransiNama;
  String? customerId;
  int? jumlahTernak;
  double? nilaiPertanggungan;
  double? nilaiPremi;

  RecapSppaDetail({
    this.id = '',
    this.recapHeaderId = '',
    this.sppaId = '',
    this.produkAsuransiCode = '',
    this.produkAsuransiNama = '',
    this.customerId = '',
    this.jumlahTernak = 0,
    this.nilaiPertanggungan = 0.0,
    this.nilaiPremi = 0.0,
  });

  factory RecapSppaDetail.fromJson(Map<String, dynamic> parsedJson) {
    return RecapSppaDetail(
        id: parsedJson['id'] as String?,
        recapHeaderId: parsedJson['recapHeaderId'] as String?,
        sppaId: parsedJson['sppaId'] as String?,
        produkAsuransiCode: parsedJson['produkAsuransiCode'] as String?,
        produkAsuransiNama: parsedJson['produkAsuransiNama'] as String?,
        customerId: parsedJson['customerId'] as String?,
        jumlahTernak: parsedJson['jumlahTernak'] as int?,
        nilaiPertanggungan: parsedJson['nilaiPertanggungan'].toDouble(),
        nilaiPremi: parsedJson['nilaiPremi'].toDouble());
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'recapHeaderId': recapHeaderId,
        'sppaId': sppaId,
        'produkAsuransiCode': produkAsuransiCode,
        'produkAsuransiNama': produkAsuransiNama,
        'customerId': customerId,
        'jumlahTernak': jumlahTernak,
        'nilaiPertanggungan': nilaiPertanggungan,
        'nilaiPremi': nilaiPremi,
      };
}
