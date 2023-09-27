
class WebImage{
  String id;
  String author;
  int width;
  int height;
  String url;
  String download_url;

  WebImage({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.download_url
  });

  factory WebImage.fromJson(Map<String,dynamic>json){
    return WebImage(
      id: json['id'],
       author: json['author'],
        width: json['width'],
         height: json['height'],
         url:json["url"],
         download_url: json["download_url"]
         );
  }

  Map<String,dynamic> toJson()=>{
    'id':id,
    'author':author,
    'width':width,
    'height':height,
    'url':url,
    'download_url':download_url
  };

}