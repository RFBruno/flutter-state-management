import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/badge.dart';
import 'package:shop/components/product_grid.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/utils/app_routes.dart';

enum FilterOptions { favorite, all }

class ProductsOverviewPage extends StatefulWidget {

  const ProductsOverviewPage({super.key});

  @override
  State<ProductsOverviewPage> createState() => _ProductsOverviewPageState();
}

class _ProductsOverviewPageState extends State<ProductsOverviewPage> {
  bool showFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Minha loja'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                child: Text('Somente Favoritos'),
                value: FilterOptions.favorite,
              ),
              const PopupMenuItem(
                child: Text('Todos'),
                value: FilterOptions.all,
              ),
            ],
            onSelected: (value) {
              setState(() {
                if (value == FilterOptions.favorite) {
                  showFavorite = true;
                } else {
                  showFavorite = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.CART,
                  );
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            builder: (context, cart, child) => Badge(
              value: cart.itemsCount.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: ProductGrid(showFavorite: showFavorite),
      drawer: AppDrawer(),
    );
  }
}
