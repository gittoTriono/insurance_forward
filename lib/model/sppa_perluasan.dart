class SppaPerluasanRisiko {
  String? id;
  String? sppaId;
  String? namaPerluasanRisiko;
  double? rate;
  int? jumlahTertanggung;
  double? nilaiPerlindungan;
  double? tambahanPremi;
  String? polisId;
  String? polisEndorsementId;

  SppaPerluasanRisiko({
    this.id = '',
    this.sppaId = '',
    this.namaPerluasanRisiko = '',
    this.rate = 0,
    this.jumlahTertanggung = 0,
    this.nilaiPerlindungan = 0.0,
    this.tambahanPremi = 0,
    this.polisId = '',
    this.polisEndorsementId = '',
  });

  factory SppaPerluasanRisiko.fromJson(Map<String, dynamic> parsedJson) {
    return SppaPerluasanRisiko(
      id: parsedJson['id'] as String?,
      sppaId: parsedJson['sppaId'] as String?,
      namaPerluasanRisiko: parsedJson['namaPerluasanRisiko'] as String?,
      rate: parsedJson['rate'].toDouble(),
      jumlahTertanggung: parsedJson['jumlahTertanggung'] as int?,
      nilaiPerlindungan: parsedJson['nilaiPerlindungan'] as double?,
      tambahanPremi: parsedJson['tambahanPremi'].toDouble(),
      polisId: parsedJson['polisId'] as String?,
      polisEndorsementId: parsedJson['polisEndorsementId'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,   // to autocreate id
        'sppaId': sppaId,
        'namaPerluasanRisiko': namaPerluasanRisiko,
        'rate': rate,
        'jumlahTertanggung': jumlahTertanggung,
        'nilaiPerlindungan': nilaiPerlindungan,
        'tambahanPremi': tambahanPremi,
        'polisId': polisId,
        'polisEndorsementId': polisEndorsementId,
      };
}
