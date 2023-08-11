import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './screens/auth-screen.dart';
import './screens/edit_product_screen.dart';
import './screens/user_products_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
// import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './screens/products_overview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          update: (ctx, auth, previousProducts) => Products(
            auth.token!,
            previousProducts == null ? [] : previousProducts.items,
          ),
          create: (_) => Products(null, []),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        )
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme:
                  ColorScheme.fromSwatch(primarySwatch: Colors.blueGrey)
                      .copyWith(secondary: Colors.deepOrange)),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            ProductDetailScreen.routName: (ctx) => ProductDetailScreen(),
            CartScreen.routName: (ctx) => CartScreen(),
            OrdersScreen.routNAme: (ctx) => OrdersScreen(),
            UserProductsScreen.routName: (ctx) => UserProductsScreen(),
            EditProductScreen.routName: (ctx) => EditProductScreen(),
            AuthScreen.routeName: (ctx) => AuthScreen(),
          },
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
