// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_app_gallery/widgets/imageCard.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';


/**
 * Here we are testing the successful inflation of our UI widgets
 * Remember to test any additions you will add to the UI
 */
void main() {
  testWidgets('Card Widget Test', (WidgetTester tester) async {
    await mockNetworkImagesFor(() async{
      await tester.pumpWidget(const Directionality(
          textDirection: TextDirection.ltr,
        child: ImageCard(
          authorName: 'John Doe',
          imageUrl: 'https://example.com/image.jpg',
        ),
        ),
      );
    });

    // Verify that our card and its contents exsist
    expect(find.byType(Card),findsOneWidget);
    expect(find.text("John Doe"),findsOneWidget);
    expect(find.byType(Image),findsOneWidget);
    
  });
}
