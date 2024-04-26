class KandangSapi {
  String? id;
  String? customerId;
  String? namaKandang;
  String? jalan;
  String? rt;
  String? rw;
  String? kelurahan;
  String? kecamatan;
  String? kota;
  String? kabupaten;
  String? kodePos;
  double? luas;
  int? kapasitas;
  String? jenis;
  String? foto1;
  String? foto2;
  String? foto3;
  String? fasilitas;
  String? status;

  KandangSapi({
    this.id = '',
    this.customerId = '',
    this.namaKandang = '',
    this.jalan = '',
    this.rt = '',
    this.rw = '',
    this.kelurahan = '',
    this.kecamatan = '',
    this.kota = '',
    this.kabupaten = '',
    this.kodePos = '',
    this.luas = 0,
    this.kapasitas = 0,
    this.jenis = '',
    this.foto1 = '',
    this.foto2 = '',
    this.foto3 = '',
    this.fasilitas = '',
    this.status = '',
  });

  factory KandangSapi.fromJson(Map<String, dynamic> parsedJson) {
    return KandangSapi(
      id: parsedJson['id'] as String?,
      customerId: parsedJson['customerId'] as String?,
      namaKandang: parsedJson['namaKandang'] as String?,
      jalan: parsedJson['jalan'] as String?,
      rt: parsedJson['rt'] as String?,
      rw: parsedJson['rw'] as String?,
      kelurahan: parsedJson['kelurahan'] as String?,
      kecamatan: parsedJson['kecamatan'] as String?,
      kabupaten: parsedJson['kabupaten'] as String?,
      kota: parsedJson['kota'] as String?,
      kodePos: parsedJson['kodePos'] as String?,
      luas: parsedJson['luas'].toDouble(),
      kapasitas: parsedJson['kapasitas'] as int?,
      jenis: parsedJson['jenis'] as String?,
      foto1: parsedJson['foto1'] as String?,
      foto2: parsedJson['foto2'] as String?,
      foto3: parsedJson['foto3'] as String?,
      fasilitas: parsedJson['fasilitas'] as String?,
      status: parsedJson['status'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
// 'id': id,
        'customerId': customerId,
        'namaKandang': namaKandang,
        'jalan': jalan,
        'rt': rt,
        'rw': rw,
        'kelurahan': kelurahan,
        'kecamatan': kecamatan,
        'kota': kota,
        'kabupaten': kabupaten,
        'kodePos': kodePos,
        'luas': luas,
        'kapasitas': kapasitas,
        'jenis': jenis,
        'foto1': foto1,
        'foto2': foto2,
        'foto3': foto3,
        'fasilitas': fasilitas,
        'status': status,
      };
}
