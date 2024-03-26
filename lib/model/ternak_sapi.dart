class TernakSapi {
  String? id;
  String? sppaId;
  int? seqNo;
  String? nama;
  String? earTag;
  int? tglLahirMillis;
  String? tglLahir;
//  int? umur;
  String? jenis;
  String? kelamin;
  double? hargaPerolehan;
  double? nilaiPertanggungan;
  int? status;
  String? polisId;
  String? polisEndorsementId;
  String? klaimId;

  TernakSapi({
    this.id = '',
    this.sppaId = '',
    this.seqNo = 0,
    this.nama = '',
    this.earTag = '',
    this.tglLahirMillis = 0,
    this.tglLahir = '',
//    this.umur = 0,
    this.jenis = '',
    this.kelamin = '',
    this.hargaPerolehan = 0,
    this.nilaiPertanggungan = 0,
    this.status = 0,
    this.polisId = "",
    this.polisEndorsementId = "",
    this.klaimId = "",
  });

  factory TernakSapi.fromJson(Map<String, dynamic> parsedJson) {
    return TernakSapi(
      id: parsedJson['id'] as String?,
      sppaId: parsedJson['sppaId'] as String?,
      seqNo: parsedJson['seqNo'] as int?,
      nama: parsedJson['nama'] as String?,
      earTag: parsedJson['earTag'] as String?,
      tglLahirMillis: parsedJson['tglLahirMillis'] as int?,
      tglLahir: parsedJson['tglLahir'] as String?,
//      umur: parsedJson['umur'] as int?,
      jenis: parsedJson['jenis'] as String?,
      kelamin: parsedJson['kelamin'] as String?,
      hargaPerolehan: parsedJson['hargaPerolehan'].toDouble(), //as double?,
      nilaiPertanggungan:
          parsedJson['nilaiPertanggungan'].toDouble(), // as double?,
      status: parsedJson['status'] as int?,
      polisId: parsedJson['polisId'] as String?,
      polisEndorsementId: parsedJson['polisEndorsementId'] as String?,
      klaimId: parsedJson['klaimId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id, to get random number
        'sppaId': sppaId,
        'seqNo': seqNo,
        'nama': nama ?? "No name",
        'earTag': earTag,
        'tglLahirMillis': tglLahirMillis,
        'tglLahir': tglLahir,
//        'umur': umur ?? 0,
        'jenis': jenis,
        'kelamin': kelamin,
        'hargaPerolehan': hargaPerolehan,
        'nilaiPertanggungan': nilaiPertanggungan,
        'status': status ?? 'BARU',
        'polisId': polisId,
        'polisEndorsementId': polisEndorsementId,
        'klaimId': klaimId,
      };
}
