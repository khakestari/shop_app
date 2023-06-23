import 'package:flutter/material.dart';

import '../widgets/products_grid.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
              // pr int(selectedValue);
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorite,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              )
            ],
            icon: const Icon(Icons.more_vert),
          )
        ],
      ),
      body: ProductsGrid(_showOnlyFavorites),
    );
  }
}

