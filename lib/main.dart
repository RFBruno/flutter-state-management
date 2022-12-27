import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/auth.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/order_list.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/models/theme.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // rotas para a propriedade router do material app
    // * final routerList = {
    // * AppRoutes.HOME: (context) => const ProductsOverviewPage(),
    // *  AppRoutes.PRODUCT_DETAIL: (context) => const ProductDetailPage(),
    // *  AppRoutes.CART: (context) => const CartPage(),
    // *  AppRoutes.ORDERS: (context) => const OrdersPage(),
    // *  AppRoutes.PRODUCTS: (context) => const ProductsPage(),
    // };

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ProductList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => OrderList(),
        ),
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
      ],
      child: ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
          builder: (context, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                fontFamily: 'Lato',
                colorScheme:
                    Provider.of<ThemeProvider>(context).isDark ? dark : light,
              ),
              // home: ProductsOverviewPage(),
              // routes: routerList,
              onGenerateRoute: AppRoutes.generateRoute,
            );
          }),
    );
  }
}