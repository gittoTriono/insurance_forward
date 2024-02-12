import 'user_data.dart';

class PageUser{

  List<UserModel> content;
  int totalPages;
  int totalElements;
  bool last;
  bool first;
  int numberOfElements;
  int size;
  int number;
  //bool empty;

  PageUser({
    required this.content,
    this.totalPages=0,
    this.totalElements=0,
    this.last=false,
    this.first=false,
    this.numberOfElements=0,
    this.size=0,
    this.number=0,
    //this.empty=true,
  });

  factory PageUser.fromJson(Map<String, dynamic> parsedJson){

    var list = parsedJson['content'] as List;
    List<UserModel> userList = list.map((item)=>UserModel.fromJson(item)).toList();

    return PageUser(
      content:             userList,
      totalPages:          parsedJson['totalPages'] as int,
      totalElements:       parsedJson['totalElements'] as int,
      last:                parsedJson['last'] as bool,
      first:               parsedJson['first'] as bool,
      numberOfElements:    parsedJson['numberOfElements'] as int,
      size:                parsedJson['size'] as int,
      number:              parsedJson['number'] as int,
      //empty:               parsedJson['empty'] as bool,
    );
  }

  Map<String, dynamic> toJson() => {
    'content':            content,
    'totalPages':         totalPages,
    'totalElements':      totalElements,
    'last':               last,
    'first':              first,
    'numberOfElements':   numberOfElements,
    'size':               size,
    'number':             number,
    //'empty':              empty,
  };

}