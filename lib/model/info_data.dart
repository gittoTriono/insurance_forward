class InfoData {

  int id;
  String pageName;
  String posName;
  int posIndex;
  int imageWidth;
  int imageHeight;
  String imageRatio;
  String thumbnailUrl;
  String pictureUrl;
  String title;
  String content;
  String style;
  String bgColor;
  String titleColor;
  String contentColor;


  InfoData({
    this.id=0,
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
    this.style='',
    this.bgColor='',
    this.titleColor='',
    this.contentColor='',

  });

  factory InfoData.fromJson(Map<String, dynamic> parsedJson){

    return InfoData(

      id:             parsedJson['id'] as int,
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
      style:          parsedJson['style'] as String,
      bgColor:        parsedJson['bgColor'] as String,
      titleColor:     parsedJson['titleColor'] as String,
      contentColor:   parsedJson['contentColor'] as String,

    );
  }

  Map<String, dynamic> toJson() =>{

    'id': id,
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
    'style': style,
    'bgColor': bgColor,
    'titleColor': titleColor,
    'contentColor': contentColor,

  };


}