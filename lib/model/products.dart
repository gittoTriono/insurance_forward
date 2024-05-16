class KategoriProduk {
  String id;
  String kategoriCode;
  String subKategoriCode;
  String kategoriDeskripsi;
  String iconFilename;
  int status;

  KategoriProduk({
    this.id = '',
    this.kategoriCode = '',
    this.subKategoriCode = '',
    this.kategoriDeskripsi = '',
    this.iconFilename = '',
    this.status = 0,
  });

  factory KategoriProduk.fromJson(Map<String, dynamic> parsedJson) {
    return KategoriProduk(
      id: parsedJson['id'] as String,
      kategoriCode: parsedJson['kategoriCode'] as String,
      subKategoriCode: parsedJson['subKategoriCode'] as String,
      kategoriDeskripsi: parsedJson['kategoriDeskripsi'] as String,
      iconFilename: parsedJson['iconFilename'] as String,
      status: parsedJson['status'] as int,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'kategoriCode': kategoriCode,
        'subKategoriCode': subKategoriCode,
        'kategoriDeskripsi': kategoriDeskripsi,
        'iconFilename': iconFilename,
        'status': status,
      };
}

// ******************************
class ProdukAsuransi {
  String? id;
  String? productCode;
  String? productName;
  String? productKategori;
  String? productSubKategori;
  String? codeAsuransi;
  String? productShortDescription;
  String? productLongDescription;
  List<dynamic>? manfaatShort;
  List<dynamic>? manfaatAdditional;
  List<dynamic>? pengecualianShort;
  List<dynamic>? pengecualianAdditional;
  List<dynamic>? tncDescription;
  List<dynamic>? klaimDescription;
  String? rateCalculationMethod;
  int? status;
  double? ratePremi;
  int? tenor;
  String? logoUri;

  ProdukAsuransi({
    this.id = '',
    this.productCode = '',
    this.productName = '',
    this.productKategori = '',
    this.productSubKategori = '',
    this.codeAsuransi = '',
    this.productShortDescription = '',
    this.productLongDescription = '',
    this.manfaatShort = const [''],
    this.manfaatAdditional = const [''],
    this.pengecualianShort = const [''],
    this.pengecualianAdditional = const [''],
    this.tncDescription = const [''],
    this.klaimDescription = const [''],
    this.rateCalculationMethod = '',
    this.status = 0,
    this.ratePremi = 0,
    this.tenor = 0,
    this.logoUri = '',
  });

  factory ProdukAsuransi.fromJson(Map<String, dynamic> parsedJson) {
    return ProdukAsuransi(
      id: parsedJson['id'] as String,
      productCode: parsedJson['productCode'] as String,
      productName: parsedJson['productName'] as String,
      productKategori: parsedJson['productKategori'] as String,
      productSubKategori: parsedJson['productSubKategori'] as String,
      codeAsuransi: parsedJson['codeAsuransi'] as String,
      productShortDescription: parsedJson['productShortDescription'] as String,
      productLongDescription: parsedJson['productLongDescription'] as String,
      manfaatShort: parsedJson['manfaatShort'] as List<dynamic>,
      manfaatAdditional: parsedJson['manfaatAdditional'] as List<dynamic>,
      pengecualianShort: parsedJson['pengecualianShort'] as List<dynamic>,
      pengecualianAdditional:
          parsedJson['pengecualianAdditional'] as List<dynamic>,
      tncDescription: parsedJson['tncDescription'] as List<dynamic>,
      klaimDescription: parsedJson['klaimDescription'] as List<dynamic>,
      rateCalculationMethod: parsedJson['rateCalculationMethod'] as String,
      status: parsedJson['status'] as int,
      ratePremi: parsedJson['ratePremi'] as double,
      tenor: parsedJson['tenor'] as int,
      logoUri: parsedJson['logoUri'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'productCode': productCode,
        'productName': productName,
        'productKategori': productKategori,
        'productSubKategori': productSubKategori,
        'codeAsuransi': codeAsuransi,
        'productShortDescription': productShortDescription,
        'productLongDescription': productLongDescription,
        'manfaatShort': manfaatShort,
        'manfaatAdditional': manfaatAdditional,
        'pengecualianShort': pengecualianShort,
        'pengecualianAdditional': pengecualianAdditional,
        'tncDescription': tncDescription,
        'klaimDescription': klaimDescription,
        'rateCalculationMethod': rateCalculationMethod,
        'status': status,
        'ratePremi': ratePremi,
        'tenor': tenor,
        'logoUri': logoUri,
      };
}

// ****************************************************************************

class PerluasanRisiko {
  String? id;
//  String? perluasanRisikoId;
// String codePerluasanRisiko;
// Strint tipe; // add main rate or add in separate line
  String? namaPerluasanRisiko;
  String? codeAsuransi;
  String? kategori;
  String? subKategori;
  String? codePreReq;
  String? deskripsi;
  List<int>? listNilaiPertanggungan;
  List<int>? listJumlahTertanggung;
  bool? selected; // for handling checkBoxes
  double? rate;
  int? status;

  PerluasanRisiko({
    this.id = '',
//    this.perluasanRisikoId = '',
    this.namaPerluasanRisiko = '',
    this.codeAsuransi = '',
    this.kategori = '',
    this.subKategori = '',
    this.codePreReq = '',
    this.deskripsi = '',
    this.listNilaiPertanggungan,
    this.listJumlahTertanggung,
    this.selected = false, // default, later set in checkbox
    this.rate = 0.0,
    this.status = 0,
  });

  factory PerluasanRisiko.fromJson(Map<String, dynamic> parsedJson) {
    return PerluasanRisiko(
      id: parsedJson['id'] as String?,
//      perluasanRisikoId: parsedJson['perluasanRisikoId'] as String?,
      namaPerluasanRisiko: parsedJson['namaPerluasanRisiko'] as String?,
      codeAsuransi: parsedJson['codeAsuransi'] as String?,
      kategori: parsedJson['kategori'] as String?,
      subKategori: parsedJson['subKategori'] as String?,
      codePreReq: parsedJson['codePreReq'] as String?,
      deskripsi: parsedJson['deskripsi'] as String?,
      listNilaiPertanggungan:
          parsedJson['listNilaiPertanggungan'] as List<int>?,
      listJumlahTertanggung: parsedJson['listJumlahTertanggung'] as List<int>?,
      selected: false, // default, later set in checkbox
      rate: parsedJson['rate'].toDouble(),
      status: parsedJson['status'] as int?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
//        'perluasanRisikoId': perluasanRisikoId,
        'namaPerluasanRisiko': namaPerluasanRisiko,
        'codeAsuransi': codeAsuransi,
        'kategori': kategori,
        'subKategori': subKategori,
        'codePreReq': codePreReq,
        'deskripsi': deskripsi,
        'listNilaiPertanggungan': listNilaiPertanggungan,
        'listJumlahTertanggung': listJumlahTertanggung,
        'rate': rate,
        'status': status,
      };
}

// **************************************************************************

class CheckBoxModal {
  String titel;
  bool value;
  double rate;
  int idx;
  CheckBoxModal(
      {required this.titel, this.value = false, this.rate = 0, this.idx = 0});
}
