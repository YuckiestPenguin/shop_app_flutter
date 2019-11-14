import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_flutter/screens/products_overview_screen.dart';
import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/product_detail_screen.dart';
import 'providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './screens/user_products_screen.dart';
import './screens/auth-screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          builder: (ctx, auth, previousProducts) => Products(auth.token,
              previousProducts == null ? [] : previousProducts.items),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
          builder: (ctx, auth, previousOrders) => Orders(
              auth.token, previousOrders == null ? [] : previousOrders.orders),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
              primarySwatch: Colors.blue,
              accentColor: Colors.deepOrange,
              fontFamily: 'Lato'),
          home: auth.isAuth ? ProductsOverviewScreen() : AuthScreen(),
          routes: {
            AuthScreen.routeName: (ctx) => AuthScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
            EditProductScreen.routeName: (ctx) => EditProductScreen(),
            ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          },
        ),
      ),
    );
  }
}
