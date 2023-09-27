import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_app_gallery/network/imageService.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'My Gallery App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Map<String, String>> imageInfo = [];
  int currentPage = 1;
  PageController pageController = PageController(initialPage: 0); 
  final ImageService imageService = ImageService(http.Client());

  Future<void> fetchImageData(int page) async {
    final data = await imageService.fetchImageData(page);

    if (data.isNotEmpty) {
      setState(() {
        imageInfo.addAll(data);
      });
    }
  }

  @override
void initState() {
  super.initState();
  fetchImageData(currentPage); 
  pageController.addListener(() {
    if (pageController.position.pixels >= pageController.position.maxScrollExtent) {
      currentPage++;
      fetchImageData(currentPage);
    }
  });
}

  @override
  void dispose() {
    pageController.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.horizontal,
              itemCount: imageInfo.length,
              itemBuilder: (context, index) {
                return ImageCard(
                  authorName: imageInfo[index]['authorName'] ?? '',
                  imageUrl: imageInfo[index]['imageUrl'] ?? '',
                );
              },
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.chevron_left),
                onPressed: () {
                  if (currentPage > 0) {
                    pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  if (currentPage < imageInfo.length - 1) {
                    // Scroll to the next page
                    pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
