class ContentData {

  int id=0;
  int parentId=0;
  String type;
  String pageName='';
  String posName='';
  int posIndex=0;
  int imageWidth=0;
  int imageHeight=0;
  String imageRatio='';
  String thumbnailUrl='';
  String pictureUrl='';
  String title='';
  String content='';
  String tag='';
  String keywords='';


  ContentData({
    this.id=0,
    this.parentId=0,
    this.type='PAGE',
    this.pageName='',
    this.posName='',
    this.posIndex=0,
    this.imageWidth=0,
    this.imageHeight=0,
    this.imageRatio='',
    this.thumbnailUrl='',
    this.pictureUrl='',
    this.title='',
    this.content='',
    this.tag='',
    this.keywords='',

  });

  factory ContentData.fromJson(Map<String, dynamic> parsedJson){

    return ContentData(

      id:             parsedJson['id'] as int,
      parentId:       parsedJson['parentId'] as int,
      type:           parsedJson['type'] as String,
      pageName:       parsedJson['pageName'] as String,
      posName:        parsedJson['posName'] as String,
      posIndex:       parsedJson['posIndex'] as int,
      imageWidth:     parsedJson['imageWidth'] as int,
      imageHeight:    parsedJson['imageHeight'] as int,
      imageRatio:     parsedJson['imageRatio'] as String,
      thumbnailUrl:   parsedJson['thumbnailUrl'] as String,
      pictureUrl:     parsedJson['pictureUrl'] as String,
      title:          parsedJson['title'] as String,
      content:        parsedJson['content'] as String,
      tag:            parsedJson['tag'] as String,
      keywords:       parsedJson['keywords'] as String,
    );
  }

  Map<String, dynamic> toJson() =>{

    'id': id,
    'parentId': parentId,
    'type': type,
    'pageName': pageName,
    'posName': posName,
    'posIndex': posIndex,
    'imageWidth': imageWidth,
    'imageHeight': imageHeight,
    'imageRatio': imageRatio,
    'thumbnailUrl': thumbnailUrl,
    'pictureUrl': pictureUrl,
    'title': title,
    'content': content,
    'tag': tag,
    'keywords': keywords,
  };


}