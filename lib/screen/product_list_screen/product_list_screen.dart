import 'package:e_commerce_flutter/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/data/data_provider.dart';
import 'components/custom_app_bar.dart';
import 'components/category_selector.dart';
import 'components/poster_section.dart';
import '../../../../widget/product_grid_view.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_) {
  //     // Fetch initial data after the first frame is rendered
  //     context.dataProvider.loadInitialData();
  //   });
  // }
  @override
  Widget build(BuildContext context) {
   


    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Hello ${context.dataProvider.getLoginUsr()?.name ?? ''}",
                //   style: Theme.of(context).textTheme.displayLarge,
                // ),
                // Text(
                //   "Lets gets somethings?",
                //   style: Theme.of(context).textTheme.headlineSmall,
                // ),
                const PosterSection(),
                Text(
                  "Top categories",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 5),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return dataProvider.isLoading || dataProvider.categories.isEmpty
                        ? _buildCategoryShimmer()
                        : dataProvider.errorMessage != null ? Text('error') : CategorySelector(categories: dataProvider.categories);
                  },
                ),
                Consumer<DataProvider>(
                  builder: (context, dataProvider, child) {
                    return dataProvider.isLoading || dataProvider.products.isEmpty
                        ? _buildProductGridShimmer()
                        : ProductGridView(items: dataProvider.products);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Shimmer effect for CategorySelector
  Widget _buildCategoryShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 90,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(5),
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5, // Placeholder for 5 category items
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
              width: 90,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        ),
      ),
    );
  }

  // Shimmer effect for ProductGridView
  Widget _buildProductGridShimmer() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: GridView.builder(
          itemCount: 6, // Placeholder for 6 product items
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 8 / 9,
            crossAxisCount: 2,
            mainAxisSpacing: 15,
            crossAxisSpacing: 20,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(5),
              ),
            );
          },
        ),
      ),
    );
  }
}