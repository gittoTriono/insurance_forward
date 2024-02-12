class Credential {

  int id;
  String cif;
  String userId;
  String partner;
  String classification;
  String attribute;
  String name;
  String alias;
  String status;
  String userTypes;
  String dob;
  String pob;
  String gender;
  String npwp="";
  String idType;
  String idNumber="";
  String idPicture;
  String personPicture;
  String cellPhoneNumber="";
  String kodeArea;
  String phoneNumber="";
  String email="";
  String roles="";
  String motherName="";
  String bankAccount="";
  String bank="";
  String type="";
  String country=""; // country
  String addressL1=""; // province
  String addressL2=""; // regency (kabupaten)
  String addressL3=""; // city
  String addressL4=""; // district (kecamatan)
  String addressL5=""; // village (desa/kelurahan)
  String addressL6=""; // RW
  String addressL7=""; // RT
  String streetAddress="";
  String building="";
  String postCode="";
  String chain="";
  String updatedBy="";
  double longitude;
  double latitude;
  bool checkDataPersonal=false;

  Credential({
    this.id=0,
    this.cif="",
    this.userId="",
    this.partner="",
    this.classification="",
    this.attribute="",
    this.name="",
    this.alias="",
    this.status="",
    this.userTypes="",
    this.dob="",
    this.pob="",
    this.gender="",
    this.npwp="",
    this.idType="",
    this.idNumber="",
    this.idPicture="",
    this.personPicture="",
    this.cellPhoneNumber="",
    this.kodeArea="",
    this.phoneNumber="",
    this.email="",
    this.roles="",
    this.motherName="",
    this.bankAccount="",
    this.bank="",
    this.type="",
    this.country="",
    this.addressL1="",
    this.addressL2="",
    this.addressL3="",
    this.addressL4="",
    this.addressL5="",
    this.addressL6="",
    this.addressL7="",
    this.streetAddress="",
    this.building="",
    this.postCode="",
    this.chain="",
    this.updatedBy="",
    this.longitude=0.0,
    this.latitude=0.0,
    this.checkDataPersonal=false,
  });

  factory Credential.fromJson(Map<String, dynamic> parsedJson){
    return Credential(
      id:                 parsedJson['id']as int,
      cif:                parsedJson['cif']as String,
      userId:             parsedJson['userId']as String,
      partner:            parsedJson['partner']as String,
      classification:     parsedJson['classification']as String,
      attribute:          parsedJson['attribute'] as String,
      name:               parsedJson['name']as String,
      alias:              parsedJson['alias']as String,
      status:             parsedJson['status']as String,
      userTypes:          parsedJson['userTypes']as String,
      dob:                parsedJson['dob']as String,
      pob:                parsedJson['pob']as String,
      gender:             parsedJson['gender']as String,
      npwp:               parsedJson['npwp']as String,
      idType:             parsedJson['idType']as String,
      idNumber:           parsedJson['idNumber']as String,
      idPicture:          parsedJson['idPicture']as String,
      personPicture:      parsedJson['personPicture']as String,
      cellPhoneNumber:    parsedJson['cellPhoneNumber']as String,
      kodeArea:           parsedJson['kodeArea'] as String,
      phoneNumber:        parsedJson['phoneNumber']as String,
      email:              parsedJson['email']as String,
      roles:              parsedJson['roles'] as String,
      motherName:         parsedJson['motherName']as String,
      bankAccount:        parsedJson['bankAccount']as String,
      bank:               parsedJson['bank']as String,
      type:               parsedJson['type']as String,
      country:            parsedJson['country']as String,
      addressL1:          parsedJson['addressL1']as String,
      addressL2:          parsedJson['addressL2']as String,
      addressL3:          parsedJson['addressL3']as String,
      addressL4:          parsedJson['addressL4']as String,
      addressL5:          parsedJson['addressL5']as String,
      addressL6:          parsedJson['addressL6']as String,
      addressL7:          parsedJson['addressL7']as String,
      streetAddress:      parsedJson['streetAddress']as String,
      building:           parsedJson['building']as String,
      postCode:           parsedJson['postCode']as String,
      chain:              parsedJson['chain']as String,
      updatedBy:          parsedJson['updatedBy']as String,
      latitude:           parsedJson['latitude']as double,
      longitude:          parsedJson['longitude']as double,
      checkDataPersonal: parsedJson['checkDataPersonal']as bool,
    );
  }

  Map<String, dynamic> toJson()=>{
    'id':                  id,
    'cif':                 cif,
    'userId':              userId,
    'partner':             partner,
    'classification':      classification,
    'attribute':           attribute,
    'name':                name,
    'alias':               alias,
    'status':              status,
    'userTypes':           userTypes,
    'dob':                 dob,
    'pob':                 pob,
    'gender':              gender,
    'npwp':                npwp,
    'idType':              idType,
    'idNumber':            idNumber,
    'idPicture':           idPicture,
    'personPicture':       personPicture,
    'cellPhoneNumber':     cellPhoneNumber,
    'kodeArea':            kodeArea,
    'phoneNumber':         phoneNumber,
    'email':               email,
    'roles':               roles,
    'motherName':          motherName,
    'bankAccount':         bankAccount,
    'bank':                bank,
    'type':                type,
    'country':             country,
    'addressL1':           addressL1,
    'addressL2':           addressL2,
    'addressL3':           addressL3,
    'addressL4':           addressL4,
    'addressL5':           addressL5,
    'addressL6':           addressL6,
    'addressL7':           addressL7,
    'streetAddress':       streetAddress,
    'building':            building,
    'postCode':            postCode,
    'chain':               chain,
    'updatedBy':           updatedBy,
    'latitude':            latitude,
    'longitude':           longitude,
    'checkDataPersonal':   checkDataPersonal,
  };

}