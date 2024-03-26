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
