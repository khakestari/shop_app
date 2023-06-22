import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // final String title;
  // ProductDetailScreen(this.title);
  static const routName = '/product-detail';
  // extract arguments

  @override
  Widget build(BuildContext context) {
    // extract arguments
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    // ...

    return Scaffold(
      appBar: AppBar(
        title: Text('title'),
      ),
    );
  }
}
