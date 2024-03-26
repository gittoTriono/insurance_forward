class Alamat {
  String? jalan;
  String? rt;
  String? rw;
  String? kelurahan;
  String? kecamatan;
  String? kota;
  String? tipeDati2;
  String? namaDati2;
  String? kodePos;

  Alamat({
    this.jalan = '',
    this.rt = '',
    this.rw = '',
    this.kelurahan = '',
    this.kecamatan = '',
    this.kota = '',
    this.tipeDati2 = '',
    this.namaDati2 = '',
    this.kodePos = '',
  });

  factory Alamat.fromJson(Map<String, dynamic> parsedJson) {
    // print('Alamat.fromJson $parsedJson');
    return Alamat(
      jalan: parsedJson['jalan'] as String?,
      rt: parsedJson['rt'] as String?,
      rw: parsedJson['rw'] as String?,
      kelurahan: parsedJson['kelurahan'] as String?,
      kecamatan: parsedJson['kecamatan'] as String?,
      kota: parsedJson['kota'] as String?,
      tipeDati2: parsedJson['tipeDati2'] as String?,
      namaDati2: parsedJson['namaDati2'] as String?,
      kodePos: parsedJson['kodePos'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'jalan': jalan,
        'rt': rt,
        'rw': rw,
        'kelurahan': kelurahan,
        'kecamatan': kecamatan,
        'kota': kota,
        'tipeDati2': tipeDati2,
        'namaDati2': namaDati2,
        'kodePos': kodePos,
      };
}
