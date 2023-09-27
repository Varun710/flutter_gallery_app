import "package:flutter_dotenv/flutter_dotenv.dart";

/// picsum.photos api doc: https://picsum.photos/
class EndPoints{

  String baseUrl = "https://picsum.photos/";

  //Returns an image with specified height and width
  String getImageSize(int width,int height){
    return "$baseUrl$width/$height";
  }

  //Default list size is 30
  String getListOfImages(){
    return "${baseUrl}v2/list";
  }

  //Returns specific image given the id
  String getImageFromId(int imageId){
    return "${baseUrl}id/$imageId";
  }

  //Returns specific image info given the id
  String getImageInfoFromId(int imageId){
    return "${baseUrl}id/$imageId/info";
  }
}