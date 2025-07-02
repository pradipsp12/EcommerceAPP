import 'package:flutter/material.dart';

import '../models/product.dart';
import '../screen/product_details_screen/product_detail_screen.dart';
import '../utility/animation/open_container_wrapper.dart';
import 'product_grid_tile.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({
    super.key,
    required this.items,
  });

  final List<Product> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: GridView.builder(
        itemCount: items.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 9 / 11,
          crossAxisCount: 2,
          mainAxisSpacing: 15,
          crossAxisSpacing: 20,
        ),
        itemBuilder: (context, index) {
          Product product = items[index];
          return OpenContainerWrapper(
            borderradius: 0,
            nextScreen: ProductDetailScreen(product),
            child: ProductGridTile(
              product: product,
              index: index,
              isPriceOff: product.offerPrice != 0,
            ),
          );
        },
      ),
    );
  }
}