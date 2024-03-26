class InfoAtsJasTan {
  String? id;
  String? sppaId;
  String? lokasiKandang;
  String? kriteriaPemeliharaan;
  String? sistemPakanTernak;
  String? infoMgmtKandang;
  String? infoMgmtPakan;
  String? infoMgmtKesehatan;

  InfoAtsJasTan({
    this.id = '',
    this.sppaId = '',
    this.lokasiKandang = '',
    this.kriteriaPemeliharaan = '',
    this.sistemPakanTernak = '',
    this.infoMgmtKandang = '',
    this.infoMgmtPakan = '',
    this.infoMgmtKesehatan = '',
  });

  factory InfoAtsJasTan.fromJson(Map<String, dynamic> parsedJson) {
    return InfoAtsJasTan(
      id: parsedJson['id'] as String?,
      sppaId: parsedJson['sppaId'] as String?,
      lokasiKandang: parsedJson['lokasiKandang'] as String?,
      kriteriaPemeliharaan: parsedJson['kriteriaPemeliharaan'] as String?,
      sistemPakanTernak: parsedJson['sistemPakanTernak'] as String?,
      infoMgmtKandang: parsedJson['infoMgmtKandang'] as String?,
      infoMgmtPakan: parsedJson['infoMgmtPakan'] as String?,
      infoMgmtKesehatan: parsedJson['infoMgmtKesehatan'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        // 'id': id,
        'sppaId': sppaId,
        'lokasiKandang': lokasiKandang,
        'kriteriaPemeliharaan': kriteriaPemeliharaan,
        'sistemPakanTernak': sistemPakanTernak,
        'infoMgmtKandang': infoMgmtKandang,
        'infoMgmtPakan': infoMgmtPakan,
        'infoMgmtKesehatan': infoMgmtKesehatan,
      };
}
