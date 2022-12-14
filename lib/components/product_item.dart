import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop/models/product.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({
    super.key,
    required this.product,
  });

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
              onPressed: () {},
              icon: const Icon(                
                Icons.edit,
              ),
              color: Theme.of(context).colorScheme.primary,
            ),
            IconButton(
              onPressed: () {},
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