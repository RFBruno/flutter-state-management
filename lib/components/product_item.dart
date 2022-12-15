import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shop/models/product.dart';
import 'package:shop/models/product_list.dart';
import 'package:shop/utils/app_routes.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

  Future<void> _showDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Excluir produto'),
          content: const Text('Tem certeza que deseja apagar esse produto ?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Não'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Sim'),
            )
          ],
        );
      },
    ).then((value) {
      if (value ?? false) {
        Provider.of<ProductList>(context, listen: false).removeProduct(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.PRODUCT_FORM,
                  arguments: product,
                );
              },
              icon: const Icon(
                Icons.edit,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () {
                _showDialog(context);
              },
              icon: const Icon(
                Icons.delete,
              ),
              color: Theme.of(context).colorScheme.error,
            ),
          ],
        ),
      ),
    );
  }
}
