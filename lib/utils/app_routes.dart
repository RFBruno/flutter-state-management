import 'package:flutter/cupertino.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shop/pages/auth_page.dart';
import 'package:shop/pages/cart_page.dart';
import 'package:shop/pages/oders_page.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/pages/product_form_page.dart';
import 'package:shop/pages/products_overview_page.dart';
import 'package:shop/pages/products_page.dart';

class AppRoutes {
  static const LOGIN = '/';
  static const HOME = '/home';
  static const PRODUCT_DETAIL = '/product-detail';
  static const CART = '/cart';
  static const ORDERS = '/orders';
  static const PRODUCTS = '/products';
  static const PRODUCT_FORM = '/products-form';

  static PageTransition doPageTransition(
      {required Widget child, RouteSettings? arguments}) {
    const Duration duration = Duration(milliseconds: 450);
    const PageTransitionType type = PageTransitionType.rightToLeftWithFade;

    return PageTransition(
        child: child, type: type, duration: duration, settings: arguments);
  }

  static Route<dynamic>? generateRoute(RouteSettings? settings) {
    switch (settings!.name) {
      case AppRoutes.PRODUCT_DETAIL:
        if (settings.arguments != null) {
          return doPageTransition(
              child: const ProductDetailPage(), arguments: settings);
        }
        return doPageTransition(
          child: const ProductsOverviewPage(),
        );
      case AppRoutes.HOME:
        return doPageTransition(
          child: const ProductsOverviewPage(),
        );
      case AppRoutes.CART:
        return doPageTransition(
          child: const CartPage(),
        );
      case AppRoutes.ORDERS:
        return doPageTransition(
          child: const OrdersPage(),
        );
      case AppRoutes.PRODUCTS:
        return doPageTransition(
          child: const ProductsPage(),
        );
      case AppRoutes.PRODUCT_FORM:
        return doPageTransition(
            child: const ProductFormPage(), arguments: settings);
      default:
        return doPageTransition(
          child: const AuthPage(),
        );
    }
  }
}
