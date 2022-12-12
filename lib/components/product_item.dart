import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/cart.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/pages/product_detail_page.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/utils/colors.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Product product = Provider.of<Product>(
      context,
      listen: false,
    );

    final Cart cart = Provider.of<Cart>(
      context,
      listen: false,
    );
    return GestureDetector(
      onDoubleTap: () => product.toggleFavorite(),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            leading: Consumer<Product>(
              builder: (_, value, child) => IconButton(
                onPressed: () {
                  product.toggleFavorite();
                },
                icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            title: Text(
              product.name,
              textAlign: TextAlign.center,
            ),
            trailing: IconButton(
              onPressed: () {
                cart.addItem(product);
              },
              icon: Icon(
                Icons.shopping_cart,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
            backgroundColor: Colors.black87,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed(AppRoutes.PRODUCT_DETAIL, arguments: product);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
