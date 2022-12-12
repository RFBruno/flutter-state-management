import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/oders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/products_page.dart';

class AppRoutes {
  static const HOME = '/';
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const PRODUCTS = '/products';

  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    const Duration duration = Duration(milliseconds: 450);
    const PageTransitionType type = PageTransitionType.rightToLeftWithFade;

    final PageTransition HOMEPAGE = PageTransition(
          child: const ProductsOverviewPage(),
          type: type,
          duration: duration,
        );
    
    switch (settings!.name) {
      case AppRoutes.PRODUCT_DETAIL:
        if (settings.arguments != null) {
          return PageTransition(
              child: const ProductDetailPage(),
              type: type,
              duration: duration,
              settings: settings);
        }
        return HOMEPAGE;
      case AppRoutes.CART:
        return PageTransition(
          child: const CartPage(),
          type: type,
          duration: duration,
        );
      case AppRoutes.ORDERS:
        return PageTransition(
          child: const OrdersPage(),
          type: type,
          duration: duration,
        );
      case AppRoutes.PRODUCTS:
        return PageTransition(
          child: const ProductsPage(),
          type: type,
          duration: duration,
        );
      default:
        return HOMEPAGE;
    }
  }
}
