import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String authorName;
  final String imageUrl;

  const ImageCard({Key? key, required this.authorName, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.deepPurple,
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(authorName, textAlign: TextAlign.center),
            Center(
              child: Image.network(
                imageUrl,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
