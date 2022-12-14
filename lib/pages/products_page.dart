import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/components/app_drawer.dart';
import 'package:shop/components/product_item.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductList product = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gerenciar Produtos'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.PRODUCT_FORM);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: product.itemsCount,
            itemBuilder: (context, index) => Column(
                  children: [
                    ProductItem(
                      product: product.items[index],
                    ),
                    const Divider()
                  ],
                )),
      ),
    );
  }
}
