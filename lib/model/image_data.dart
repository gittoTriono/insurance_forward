import 'package:get/get.dart';

class ImageData{

  String id;
  String userId;
  String token;
  String name;
  String content;
  var img;
  bool available;
  var imageAvailable = RxBool(false).obs;

  ImageData({
    this.id='',
    this.userId='',
    this.token='',
    this.name='',
    this.content='',
    this.img,
    this.available=false,
  });

  factory ImageData.fromJson(Map<String, dynamic> parsedJson){

    return ImageData(
        id:      parsedJson['id'],
        userId:  parsedJson['userId'],
        token:   parsedJson['token'],
        name:    parsedJson['name'],
        content: parsedJson['content']

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'userId': userId,
    'token': token,
    'name': name,
    'content': content
  };

}

class ImageTaking {

  final String name;
  final String title;
  final String picture;
  final String ratio;
  final int width;
  final int height;
  final int quality;

  ImageTaking({
    this.name="",
    this.title="",
    this.picture="",
    this.ratio="",
    this.width=0,
    this.height=0,
    this.quality=0,
  });

}

class ImageSimple{

  String id;
  String name;
  String content;
  var img;
  bool available;

  ImageSimple({
    this.id='',
    this.name='',
    this.content='',
    this.img,
    this.available=false,
  });

  factory ImageSimple.fromJson(Map<String, dynamic> parsedJson){

    return ImageSimple(
        id:      parsedJson['id'],
        name:    parsedJson['name'],
        content: parsedJson['content']

    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'content': content
  };

}