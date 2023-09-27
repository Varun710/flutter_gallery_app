import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/network/endpoints.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class ImageScrollPage extends StatefulWidget {
  @override
  _ImageScrollPageState createState() => _ImageScrollPageState();
}

class _ImageScrollPageState extends State<ImageScrollPage> {

  List<String> imageUrls = [];
  List<String> authors = [];
  
  fetchImages() async {
    final endpoint = EndPoints();
    
    try {
      final response = await http.get(endpoint.getListOfImages());
      final ids = jsonDecode(response.body);

      for(var id in ids) {
        final imgResponse = await http.get(endpoint.getImageFromId(id));
        final imgUrl = jsonDecode(imgResponse.body)['download_url'];

        final infoResponse = await http.get(endpoint.getImageInfoFromId(id));
        final author = jsonDecode(infoResponse.body)['author'];

        imageUrls.add(imgUrl);
        authors.add(author);
      }
    } catch (err) {
      print('Error fetching images: $err');
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchImages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Image Scroll')),
      body: FutureBuilder(
        future: fetchImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Container(
              height: 300,
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageUrls.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Text(authors[index] ?? 'Unknown'),
                      Image.network(imageUrls[index]),
                    ],
                  );
                },
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());  
          }
        },
      ),
    );
  }
}
