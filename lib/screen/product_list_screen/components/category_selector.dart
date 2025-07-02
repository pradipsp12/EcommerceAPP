import '../../product_by_category_screen/product_by_category_screen.dart';
import '../../../utility/animation/open_container_wrapper.dart';
import 'package:flutter/material.dart';
import '../../../models/category.dart';

class CategorySelector extends StatelessWidget {
  final List<Category> categories;


  const CategorySelector({
    super.key,
    required this.categories,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 5),
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.greenAccent,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 6,vertical: 1),
            child: OpenContainerWrapper(
              borderradius: 5,
              nextScreen: ProductByCategoryScreen(selectedCategory: categories[index]),
              child: Container(
                
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: category.isSelected ? const Color(0xFFf16b26) : const Color(0xFFE5E6E8),
                  borderRadius: BorderRadius.circular(0),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Image.network(
                        category.image ?? '',
                        width: 90,
                        height: 90,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.error, color: Colors.grey);
                        },
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.name ?? '',
                      style: TextStyle(
                        color: category.isSelected ? Colors.white : Colors.black,
                        fontSize: 12,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
