import 'package:e_commerce_flutter/models/product.dart';
import 'package:e_commerce_flutter/screen/product_favorite_screen/provider/favorite_provider.dart';
import 'package:e_commerce_flutter/utility/extensions.dart';
import 'package:e_commerce_flutter/utility/utility_extention.dart';
import 'package:e_commerce_flutter/widget/custom_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductGridTile extends StatelessWidget {
  final Product product;
  final int index;
  final bool isPriceOff;

  const ProductGridTile({
    super.key,
    required this.product,
    required this.index,
    required this.isPriceOff,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final discountPercentage = context.dataProvider
        .calculateDiscountPercentage(product.price ?? 0, product.offerPrice ?? 0);
    final hasDiscount = discountPercentage != 0;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Product Image
              Expanded(
                child: Container(
                  decoration:const BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(0),
                    ),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: CustomNetworkImage(
                      imageUrl: product.images!.isNotEmpty
                          ? product.images?.safeElementAt(0)?.url ?? ''
                          : '',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),

              // Product Details
              Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Product Name
                    Text(
                      product.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Price Row
                    Row(
                      children: [
                        // Current Price
                        Text(
                          '\$${product.offerPrice != 0 ? product.offerPrice : product.price}',
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),

                        // Original Price (if discounted)
                        if (hasDiscount)
                          Text(
                            '\$${product.price}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey.shade600,
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Discount Badge
          if (hasDiscount)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.red.shade600,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '${discountPercentage.toInt()}% OFF',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          // Favorite Button
          Positioned(
            top: 8,
            right: 8,
            child: Consumer<FavoriteProvider>(
              builder: (context, favoriteProvider, child) {
                return IconButton(
                  icon: Icon(
                    favoriteProvider.checkIsItemFavorite(product.sId ?? '')
                        ? Icons.favorite
                        : Icons.favorite_border,
                    color: favoriteProvider.checkIsItemFavorite(product.sId ?? '')
                        ? Colors.red
                        : Colors.grey.shade600,
                    size: 24,
                  ),
                  onPressed: () {
                    context.favoriteProvider
                        .updateToFavoriteList(product.sId ?? '');
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.9),
                    padding: const EdgeInsets.all(4),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}